# require "open-uri"
# require "nokogiri"

# # Let's scrape recipes from https://www.bbcgoodfood.com

# ingredient = "bananas"
# url = "https://www.bbcgoodfood.com/search/recipes?q=#{ingredient}"

# html_file = URI.open(url).read
# html_doc = Nokogiri::HTML.parse(html_file)


# # p html_doc

# html_doc.search(".layout-md-rail__primary .card__content a").each do |element|
#   p element.text
#   p element.attribute("href").value
#   # puts element.text.strip
#   # puts element.attribute("href").value
#   puts "--------------------------------"
# end

# # Utilizamos el metodo search

require "open-uri"
require "nokogiri"

recipe = "chicken"
url = "https://www.allrecipes.com/search?q=#{recipe}"

html_file = URI.open(url).read
html_doc = Nokogiri::HTML.parse(html_file)

titles = []
images = []
numbers = []

html_doc.search("#mntl-search-results_1-0 img").each do | image |
  img_src = image['src']
  images << img_src
  # p img_src
end

html_doc.search("#mntl-search-results_1-0 .card__title-text").each do | receta |
  title = receta.text.strip
  titles << title
  # p title
end

html_doc.search("#mntl-search-results_1-0 .mntl-recipe-card-meta__rating-count-number").each do | number_ranking |
  number = number_ranking.text.gsub("\n", ' ').strip
  numbers << number
  # p numbers
end

# Crear archivo HTML con los resultados
File.open('index.html', 'w') do |file|
  file.puts <<-HTML
  <html>
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recetas </title>
     <!-- CSS -->
     <link rel="stylesheet" href="style.css">
     <!-- Google fonts -->
     <link rel="preconnect" href="https://fonts.googleapis.com">
     <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
     <link href="https://fonts.googleapis.com/css2?family=Raleway:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
  </head>
  <body>

    <section class="recipe-section">
      <h1>Recetas</h1>
      <section class="recipe-container">
    HTML

    titles.each_with_index do |title, index|
       # Verificar si la tarjeta tiene datos válidos
        if titles.to_s.strip.empty? || images[index].to_s.strip.empty? || numbers[index].to_s.strip.empty?
          puts "No hay datos para esta receta. Se omite."
        else
          file.puts <<-HTML

            <div class="recipe-card">
              <img src="#{images[index]}" alt="Imagen de la Receta">
              <div class="details">
                <h4 class="title">#{title}</h4>
                <span class="ranking">#{numbers[index]}</span>
              </div>
            </div>

            HTML
        end
      end

    file.puts <<-HTML
      </section>
    </section>
  </body>
</html>
  HTML
end

puts "Datos guardados en index.html"

# titles.each_with_index do |title, index|
#   # Verificar si la tarjeta tiene datos válidos
#   # if title.to_s.strip.empty? || images[index].to_s.strip.empty? || release_dates[index].to_s.strip.empty? || descriptions[index].to_s.strip.empty?
#   #   puts "No hay datos para esta película. Se omite."
#   # else
#     file.puts <<-HTML

#       <div class="recipe-card">
#         <img src="#{images[index]}" alt="Imagen de la Receta">
#         <div class="details">
#           <h4 class="title">#{title}</h4>
#           <span class="ranking"><strong>#{number[index]}</strong></span>
#         </div>
#       </div>

#       HTML
#   # end
# end
