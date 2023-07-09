import Base.stack

@TypstTxtElem(TypstText)
@TypstTxtElem(TypstImage)
@TypstTxtElem(TypstBibliography)

@TypstMonoStdElem(TypstPar)
@TypstMonoStdElem(TypstScale)
@TypstMonoStdElem(TypstFootnote)
@TypstMonoStdElem(TypstMove)
@TypstMonoStdElem(TypstEllipse)
@TypstMonoStdElem(TypstCircle)
@TypstMonoStdElem(TypstPath)
@TypstMonoStdElem(TypstPolygon)
@TypstMonoStdElem(TypstRect)
@TypstMonoStdElem(TypstSquare)

@TypstStdElem(TypstGrid)
@TypstStdElem(TypstBlock)
@TypstStdElem(TypstStack)
@TypstStdElem(TypstList)
@TypstStdElem(TypstEnum)
@TypstStdElem(TypstPage)
@TypstStdElem(TypstTable)
@TypstStdElem(TypstTerms)

@TypstContr(TypstPagebreak)
@TypstContr(TypstColbreak)
@TypstContr(TypstDocument)
@TypstContr(TypstOutline)
@TypstContr(TypstLine)

@TypstContr(TypstEllipse)
@TypstContr(TypstCircle)
@TypstContr(TypstPath)
@TypstContr(TypstPolygon)
@TypstContr(TypstRect)
@TypstContr(TypstSquare)


text(::Nothing) = text("")

heading(content::String; kw...) = TypstBaseElement(TypstHeading, content, Dict(kw) |> allbutlabel, haskey(kw, :label) ? Dict(kw)[:label] : nothing)

figure(content::TypstElement; kw...) = TypstBaseElement(TypstFigure, content, Dict(kw) |> allbutlabel, haskey(kw, :label) ? Dict(kw)[:label] : nothing)

columns(content::TypstVec, num::Int; kw...) = TypstColumns(AbstractTypst[content...], opts(kw), num)

ref(label::Symbol; kw...) = TypstReference(label, Dict(kw))

math(expr::String) = TypstMath(expr)

numbering(a...) = TypstNumbering([a...])

cite(a...; kw...) = TypstCite(Stringlike[a...], opts(kw))

cite(a; kw...) = TypstCite(Stringlike[a], opts(kw))

place(content, align; kw...) = TypstPlace(content, opts(kw), align)

rotate(content, angle::TypstAngle; kw...) = TypstRotate(content, opts(kw), angle)

literal(string::String) = TypstLiteral(string)

lorem(i::Int) = TypstLorem(i)

luma(value::T) where {T <: Int} = TypstLuma(value)

luma(value::UInt8) = TypstLuma(value)

rgb(r::S, g::B, b::Z) where {S, B, Z <: Int} = TypstRGB(r, g, b)

cmyk(c::C, m::M, y::Y, k::K) where {C, M, Y, K <: Real} = TypstCMYK(c, m, y, k)

deg(value::T) where {T <: Real} = TypstAngle(value)

align(content::TypstElement, align::Union{Symbol, AbstractString}) = TypstAlign(content, align)

link(content::TypstElement, dest::AbstractString) = TypstLink(content, dest)

flex(i :: Int) = fr(1,i)

flex(v :: Vector) = FlexMeasures[v...]


v(l::TypstLength) = TypstV(l)
h(l::TypstLength) = TypstH(l)

function_to_type(a) = eval(Dict(map(reverse, collect(typedict)))[string(a)])

set(a, b) = TypstSet(function_to_type(a), b)

set(a; kw...) = TypstSet(function_to_type(a), opts(kw))