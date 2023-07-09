using TypstGenerator

function gen_example()

	le = text.(split("Lorem ipsum dolor sit amet", " "))

	pathbase = endswith(pwd(), "example") ? "" : "example/"

	julia_svg = pathbase * "julia.svg"
	typst_png = pathbase * "typst_banner.png"
	bib = pathbase * "bibliography.bib"

	page1 = page(
		outline(),
		heading("Report", level = 1),
		v(12mm),
		set(align, :center),
		grid(map(x -> rect(align(text(string(x)), :horizon), width = x * 3mm, height = 10mm), 1:3)...),
		set(align, :left),
		lorem(200),
		heading("Important Topic", level = 2),
		lorem(200),
		set(align, :center),
	)

	page2 = page(
		grid(map(x -> rotate(
					square(
						align(
							math(" A =  pi r^2 "), :bottom),
						size = 20mm, fill = rgb(0x21, min(0xff, x * 3), 100)), deg(x)), 1:5:90),
			columns = fr(1, 18),
		),
		v(1cm),
		figure(
			image(julia_svg, height = 50mm),
			caption = text("The Julia language logo"),
			label = :test_fig,
		),
		align(
			block(
				[
					numbering("i.i)", 3^12, 2349),
					lorem(20),
					ref(:test_fig),
					lorem(20),
					math(" A = pi ^2 "),
					lorem(20),
					footnote(lorem(10)),
					math("A = pi ^2"),
					lorem(20),
				],
				inset = 12pt,
				radius = 2mm,
				fill = cmyk(0.1, 0.2, 0.3, 0.1)), :center),
		v(2cm),
		grid(
			[
				list(le),
				enum(
					map(x ->
							grid([
									text("x^$(x)"),
								],
								columns = [30pt, 10pt],
							), 1:length(le)),
				),
				enum(le),
				enum([le..., enum(le, full = true, start = 4)]),
			],
			columns = fr(1, 4)),
		background = place(rotate(text("WATERMARK", size = 6cm, font = "Source Sans Pro", fill = luma(0xcc)), deg(45)), :center + :horizon))

	page3 = page(
		figure(
			grid(map(x -> square(size = 2mm * x), 1:5:25),
				columns = fr.(1:5),
			),
			caption = "The industrial revolution was a distaster for mankind",
			label = :uncle_ted,
		),
		set(par, justify = true),
		lorem(100),
		cite(:netwok2020),
		lorem(50),
		ref(:uncle_ted),
		lorem(50),
		columns(
			lorem(100),
			heading("Par", level = 4, outlined = false),
			lorem(100),
			bibliography(bib),
		),
		margin = (
			left = 20mm,
			right = 20mm,
		),
	)

	settings = [
		set(page,
			margin = (left = 20mm, right = 20mm, top = 30mm, bottom = 30mm),
			footer = grid([align(image(typst_png, height = 12mm), :left), align(image(julia_svg, height = 12mm), :right)],
				columns = [fr(1), fr(1)],
			)),
		set(heading, numbering = "I.I"),
	]

	return [settings..., page1, page2, page3]
end

function render_example(t)
	typst(t, title = "Report", authors = ["Author"])
end

function run_exmaple()
	write("test.typ", gen_example() |> render_example)
	run(`typst compile test.typ`)
end

