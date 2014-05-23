
#reads the movies from the csv file and returns an array
def read_movies_csv(csv)
  all_movies = []
  CSV.foreach(csv, headers: true, header_converters: :symbol) do |row|
    all_movies << row
  end
  all_movies
end

#gives the page number and which movie index to display
def pagination(model, page, offset)
  if page == 1
    model = model[0..20]
  else
    model = model[offset+1..offset+20]
  end
end
