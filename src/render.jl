struct TypstContext
	brackets::Bool
	table::Bool
	listable::Bool
	block::Bool
	indent::Int
end

import Base.+
+(a::Symbol, b::Symbol) = string(a) * " + " * string(b)

create_context(
	brackets::Bool,
	indent::Int = 0;
	table::Bool = false,
	listable::Bool = false,
	block::Bool = false) = TypstContext(brackets, table, listable, block, indent)

hash(c::TypstContext) = c.brackets ? "#" : ""

indent(c::TypstContext) = repeat("  ", c.indent)

show(t::TypstContext) = indent(t) * hash(t)

render(t::TypstContext) = indent(t) * hash(t)

show(t::Bool) = "$(t)"

show(t::AbsoluteLength)::String = "$(t.value)mm"

show(t::RelativeLength)::String = "$(t.value * 100 |> round |> Int)%"

show(t::Fractional)::String = "$(t.val)fr"

render(t::TypstSpacing, context::TypstContext) = "$(render(context,t))($(getproperty(t, :spacing)))"

render(i::Int) = i

render(i::Float64) = "$(i * 100 |> round |> Int)%"

render(i::AbsoluteLength) = i |> show

render(i::Bool) = i |> show

render(i::TypstLuma) = "luma($(i.value))"

render(i::TypstCMYK) = "cmyk($(i.cyan |> render), $(i.magenta |> render), $(i.yellow |> render), $(i.key |> render))"

render(i::TypstRGB) = "rgb($(i.r), $(i.g), $(i.b))"

render(i::TypstAngle) = "$(i.value)deg"

render(t::Flex)::String = isempty(t) ? "" : "($(join(show.(t), ", ")))"

render(t::Pair{Symbol, Any}) = "$(replace(string(t[1]), "_" => "-")): $((t[2] |> typeof <: TypstElement) ? render(t[2], create_context(false)) : render(t[2]))"

render(t::Pair{Symbol, TypstElement}) = "$(t[1]): $(t[2] |> render)"

render(t::Pair{Symbol, TypstVec}) = "$(t[1]): $(t[2] |> render)"

render(t::Pair{Symbol, Union{AbstractString, Symbol}}) = """$(replace(string(t[1]), "_" => "-")): $(t[2] |> render)"""

render(e::Union{AbstractString, Symbol}, context::TypstContext) = """\"$(e)\""""

render(e::AbstractString) = """\"$(e)\""""

render(e::Symbol) = "$(e)"

render(e::NamedTuple) = "($(join(map(x -> "$(render(x[1])): $(render(x[2]))", e |> pairs |> collect), ", ")))"

render(e::TypstLiteral, _) = e.string

render(e::TypstNumbering, context::TypstContext) = """$(render(context,e))($(join(map(x -> typeof(x) <: AbstractString ? "\"$(x)\"" : "$(x)",  e.numbering), ", ")))"""

render(c::TypstContext, e) = "$(render(c))$(name(e))"

render(e::TypstMath, _) = "\$$(e.expr)\$"

render(t::TypstLink, context::TypstContext) = "$(render(context,t))(\"$(t.dest)\", $(render(t.content,create_context(false, context.indent))))"

render(e::TypstVec, context::TypstContext)::String = "\n" * join(map(x -> render(x, context), e), context.brackets && !context.table ? "\n" : ",\n")

render(t::TypstAlign, context::TypstContext) = "$(render(context,t))($(t.align), $(render(t.content,create_context(false, context.indent))))"

render(t::TypstColumns, context::TypstContext) = "$(render(context,t))($(t.num)$(render(t.options,prefixif = ", ")))[$(render(t.content,create_context(true, context.indent + 1)))]"

render(e::BaseOptions; prefixif = "", suffixif = "") = isempty(e) ? "" : "$(prefixif)$(join(e |> collect .|> render, ", "))$(suffixif)"

render(e::TypstCite, context::TypstContext) = "$(render(context,e))($(join(map(ref -> "\"$(ref)\"", e.refs), ", "))$(render(e.options, prefixif = ", ")))"

render(e::TypstPlace, context::TypstContext) = "$(render(context,e))($(e.alignment),$(render(e.options, suffixif = ", "))$(render(e.content, create_context(false, context.indent + 1))))"

render(e::TypstRotate, context::TypstContext) = "$(render(context,e))($(render(e.angle)),$(render(e.options)))[$(render(e.content, create_context(true, context.indent + 1)))]"

render(e::TypstSet, context::TypstContext) = "$(context |> render)set $(e.type |> name)($(render(e.options)))"

render(e::TypstSingle, context::TypstContext) = "$(render(context,e))($(getproperty(e, fieldnames(typeof(e))[1])))"

render(e::TypstReference, context::TypstContext) = "$(render(context,e))($(render(e.options))<$(e.label)>)"

render(e::Type, ref::Option{Symbol}) = e <: TypstReferable && !isnothing(ref) ? "<$(ref)>" : ""

Base.isnumeric(s::Union{AbstractString, AbstractChar}) = tryparse(Float64, s) !== nothing

function render(e::TypstBaseElement, context::TypstContext)::String
	if e.type == TypstText
		println(context)
		c = (e.content |> isnumeric && !context.table) ? render(string(e.content)) : string(e.content)
		return (((context.brackets || context.table) && !(context.listable || context.block)) ? "[$(c)]" : c)
	elseif e.type == TypstHeading
		return repeat("=", haskey(e.options, :level) ? e.options[:level] : 1) * " $(e.content)"
	elseif e.type == TypstList && e.options |> isempty
		println(context)
		str = join(map(x -> "- " * render(x, TypstContext(true, false, true, false, context.indent)), e.content), "\n")
		context.indent ≥ 1 ? "[$(str)]" : str
	elseif e.type == TypstEnum && e.options |> isempty
		str = join(map(x -> "+ " * render(x, TypstContext(true, false, true, false, context.indent)), e.content), "\n")
		context.indent ≥ 1 ? "[$(str)]" : str
	else
		println(e.type)

		newcontext = create_context(e.type <: TypstBracket, context.indent + 1, table = e.type <: Union{TypstTable, TypstListable}, listable = false, block = e.type == TypstBlock)

		return render(context, e.type) *
			   (
				   newcontext.brackets ?
				   newcontext.table ?
				   "($(render(e.options, suffixif = ", ")) $(render(e.content, newcontext)))" :
				   "($(render(e.options)))[$(render(e.content, newcontext))]" :
				   "($(render(e.options, suffixif = ", "))$(typeof(e) == TypstBaseElement ? render(e.content, newcontext) : "")) "
			   ) * render(e.type, e.ref)
	end
end

function render(e::TypstBaseControlls, context::TypstContext)::String
	newcontext = create_context(e.type <: TypstBracket || hasfield(typeof(e), :content), context.indent + 1)
	render(context, e.type) * (newcontext.brackets ?
							   "($(render(e.options)))[$(render(e.content, newcontext))]" :
							   "($(render(e.options, suffixif = ", "))$(typeof(e) == TypstBaseElement ? render(e.content, newcontext) : "")) ") * render(e.type, e.ref)
end

