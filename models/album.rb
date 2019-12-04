require('pg')
require_relative('../db/sql_runner')

class Album

  attr_reader :id, :artist_id
  attr_accessor :title, :genre

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i
  end

  def save()
    sql = "INSERT INTO albums (
      title,
      genre,
      artist_id
    ) VALUES ( $1, $2, $3 ) RETURNING id;"
    values = [@title, @genre, @artist_id]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM albums;"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM albums;"
    results = SqlRunner.run(sql)
    albums = results.map { |album| Album.new(album) }
    return albums
  end

  def find_artist()
    sql = "SELECT * FROM artists WHERE id = $1;"
    values = [@artist_id]
    result = SqlRunner.run(sql, values)[0]
    artist = Artist.new(result)
    return artist
  end

  def update()
    sql = "UPDATE albums SET (title, genre) = ($1, $2) WHERE id = $3;"
    values = [@title, @genre, @id]
    SqlRunner.run(sql, values)
  end

end
