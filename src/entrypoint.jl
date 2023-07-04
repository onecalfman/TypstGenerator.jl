
gen_header(title::String, authors::Vector{String})::String = """
#let project(title, doc) = {
set document(author: ($(join(map(x -> "\"$(x)\"",authors), ", "))), title: title)
doc
}
#show: project.with("$title")
	"""

typst(
    content::Union{AbstractTypst, Vector{AbstractTypst}}; 
    title::String = "", 
    authors::Vector{String} = [])::String = gen_header(title, authors) * render(content, create_context(true))