
gen_header(title::String, authors::Vector{String})::String = """
#let project(title, doc) = {
set document(author: ($(join(map(x -> "\"$(x)\"",authors), ", "))), title: title)
doc
}
#show: project.with("$title")
	"""

TypstElements = Union{AbstractTypst, Vector{AbstractTypst}, Vector{TypstBaseElement}}

function typst(content::T; title::AbstractString, authors::Vector{AbstractString}) where {T <: TypstElements}
    gen_header(title, authors) * render(content, create_context(true))
end
    
typst(content) = typst(content::T, title = "Document", authors = ["anonymous"]) where {T <: TypstElements}