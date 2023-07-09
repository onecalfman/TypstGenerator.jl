
abstract type AbstractTypst end
abstract type TypstElement <: AbstractTypst end
abstract type TypstOptions <: AbstractTypst end
abstract type TypstControlls <: TypstElement end
abstract type TypstBracket <: TypstElement end
abstract type TypstParen <: TypstElement end
abstract type TypstReferable <: TypstParen end
abstract type TypstMeta <: TypstElement end

abstract type TypstGeometry <: TypstElement end

abstract type TypstSingle <: TypstControlls end
abstract type TypstSpacing <: TypstSingle end
abstract type TypstUnits <: AbstractTypst end
abstract type TypstColors <: AbstractTypst end

Option{T} = Union{T, Nothing}

ColorType = Option{Union{Symbol, Int}}

TypstVec = Vector{T} where {T <: AbstractTypst}

TypstContent = Union{TypstElement, TypstVec, Tuple{TypstElement}}

struct RelativeLength
	value::Float64
end

import Base.show
import Base.println
import Base.print
import Base.*
import Base.+
import Base.-
import Base./
import Base.%

Base.zero(r::RelativeLength)    = RelativeLength(0)
/(r::RelativeLength, n::Number) = r.value / n
*(r::RelativeLength, n::Number) = r.value * n
+(r::RelativeLength, n::Number) = r.value + n
-(r::RelativeLength, n::Number) = r.value - n
%(n::Real)                      = RelativeLength(n / 100)

struct Fractional <: AbstractTypst
	val::Int64
end

import Base.repeat
repeat(e::Fractional, n::Int) = [e for i in 1:n]

fr(i::Int) = Fractional(i)

fr(i::Int, n::Int) = repeat(fr(i), n)

TypstLength = Option{Union{AbsoluteLength, RelativeLength, Real, Fractional}}

FlexMeasures = Union{Fractional, AbsoluteLength}

TypstStroke = Option{Union{TypstLength, Symbol, Dict{Symbol, Symbol}}}

Gutter = Union{TypstLength, Vector{FlexMeasures}}

Flex = Option{Union{Vector{FlexMeasures}, Vector{Fractional}, Vector{AbsoluteLength}}}

Stringlike = Union{AbstractString, Symbol}

Numbering = Vector{Union{Stringlike, Int}}

Citations = Union{Stringlike, Vector{Stringlike}}

BaseOptions = Dict{Symbol, Any}

opts(args...)::Dict{Symbol, Any} = d::Dict(args)

opts(args::Base.Pairs)::Dict{Symbol, Any} = Dict(args)

struct TypstBaseElement <: TypstElement
	type::Type
	content::Union{AbstractString, Symbol, TypstElement, TypstVec}
	options::BaseOptions
	ref::Option{Symbol}
end

struct TypstAngle <: TypstUnits
	value::Float64
end


struct TypstBaseControlls <: TypstElement
	type::Type
	options::BaseOptions
	ref::Option{Symbol}
end

TypstBaseElement(
	type::Type,
	content::Union{AbstractString, Symbol, TypstElement, TypstVec},
	options::BaseOptions,
) = TypstBaseElement(type, content, options, nothing)

TypstBaseControlls(
	type::Type,
	options::BaseOptions) = TypstBaseControlls(type, options, nothing)


abstract type TypstText <: TypstElement end
abstract type TypstImage <: TypstElement end
abstract type TypstPar <: TypstElement end

abstract type TypstGrid <: TypstParen end
abstract type TypstList <: TypstParen end
abstract type TypstScale <: TypstParen end
abstract type TypstEnum <: TypstParen end
abstract type TypstTable <: TypstParen end
abstract type TypstStack <: TypstParen end
abstract type TypstMove <: TypstParen end
abstract type TypstRepeat <: TypstParen end
abstract type TypstPad <: TypstParen end
abstract type TypstBibliography <: TypstParen end

abstract type TypstBlock <: TypstBracket end
abstract type TypstPage <: TypstBracket end
abstract type TypstTerms <: TypstBracket end
abstract type TypstFootnote <: TypstBracket end

abstract type TypstHeading <: TypstReferable end
abstract type TypstFigure <: TypstReferable end

abstract type TypstColbreak <: TypstControlls end
abstract type TypstPagebreak <: TypstControlls end
abstract type TypstLine <: TypstControlls end

abstract type TypstEllipse <: TypstGeometry end
abstract type TypstCircle <: TypstGeometry end
abstract type TypstPath <: TypstGeometry end
abstract type TypstPolygon <: TypstGeometry end
abstract type TypstRect <: TypstGeometry end
abstract type TypstSquare <: TypstGeometry end

abstract type TypstDocument <: TypstControlls end
abstract type TypstOutline <: TypstControlls end


struct TypstAlign <: TypstControlls
	content::TypstElement
	align::Union{Symbol, AbstractString}
end

struct TypstLink <: TypstMeta
	content::TypstElement
	dest::AbstractString
end

struct TypstPlace <: TypstControlls
	content::TypstElement
	options::BaseOptions
	alignment::Union{Symbol, AbstractString}
end

struct TypstRotate <: TypstControlls
	content::TypstElement
	options::BaseOptions
	angle::TypstAngle
end

struct TypstCite <: TypstMeta
	refs::Citations
	options::BaseOptions
end

struct TypstNumbering <: TypstControlls
	numbering::Numbering
end

struct TypstLorem <: TypstSingle
	length::Int
end

struct TypstV <: TypstSpacing
	spacing::AbsoluteLength
end

struct TypstH <: TypstSpacing
	spacing::AbsoluteLength
end

struct TypstSet <: AbstractTypst
	type::Type
	options::Union{BaseOptions, Symbol, TypstLength}
end
struct TypstMath <: TypstMeta
	expr::String
end

struct TypstLiteral <: TypstMeta
	string::String
end
struct TypstReference <: TypstMeta
	label::Symbol
	options::BaseOptions
end

struct TypstLuma <: TypstColors
	value::Int
end
struct TypstRGB <: TypstColors
	r::Int
	g::Int
	b::Int
end

struct TypstCMYK <: TypstColors
	cyan::Float64
	magenta::Float64
	yellow::Float64
	key::Float64
end

function allbutlabel(d::Dict{Symbol, T}) where T
	delete!(d, :label)
	return d
end

typedict = Dict(
	:TypstAlign => "align",
	:TypstBlock => "block",
	:TypstBibliography => "bibliography",
	:TypstCircle => "circle",
	:TypstCite => "cite",
	:TypstColbreak => "colbreak",
	:TypstDocument => "document",
	:TypstEllipse => "ellipse",
	:TypstEnum => "enum",
	:TypstFigure => "figure",
	:TypstFootnote => "footnote",
	:TypstGrid => "grid",
	:TypstH => "h",
	:TypstHeading => "heading",
	:TypstImage => "image",
	:TypstLine => "line",
	:TypstLink => "link",
	:TypstList => "list",
	:TypstLiteral => "",
	:TypstLorem => "lorem",
	:TypstMove => "move",
	:TypstNumbering => "numbering",
	:TypstOutline => "outline",
	:TypstPad => "pad",
	:TypstPage => "page",
	:TypstPagebreak => "pagebreak",
	:TypstPar => "par",
	:TypstPath => "path",
	:TypstPlace => "place",
	:TypstPolygon => "polygon",
	:TypstRect => "rect",
	:TypstRepeat => "repeat",
	:TypstReference => "ref",
	:TypstRotate => "rotate",
	:TypstScale => "scale",
	:TypstSquare => "square",
	:TypstStack => "stack",
	:TypstTable => "table",
	:TypstTerms => "terms",
	:TypstText => "text",
	:TypstV => "v",
)

name(t::TypstBaseElement)::String = t.type |> name

name(t::TypstElement)::String = t |> typeof |> name

name(t::Type)::String = t |> Symbol |> name

name(t::Symbol)::String = typedict[Symbol(replace(string(t), "TypstGenerator." => ""))]

function Base.convert(t :: Type{AbstractTypst}, str::String)::AbstractTypst
	d :: Dict{Symbol,Any} = Dict()
	TypstBaseElement(TypstText, str, d)
end

function Base.convert(t :: Type{AbstractTypst}, str::Any)::AbstractTypst
	d :: Dict{Symbol,Any} = Dict()
	TypstBaseElement(TypstText, string(str), d)
end

macro TypstTxtElem(t::Symbol)
	@eval $(t |> name |> Symbol)(content::AbstractString; kw...) = TypstBaseElement($t, content, opts(kw))
end

macro TypstMonoStdElem(t::Symbol)
	@eval $(t |> name |> Symbol)(content :: TypstElement; kw...) = TypstBaseElement($t, content, opts(kw))
end

macro TypstStdElem(t::Symbol)
	@eval function $(t |> name |> Symbol)(content...; kw...)
		TypstBaseElement($t, typeof(content) <: Tuple{Vector} ? content[1] : AbstractTypst[content...], opts(kw))
	end
end

macro TypstContr(t::Symbol)
	@eval $(t |> name |> Symbol)(; kw...) = TypstBaseControlls($t, opts(kw))
end
