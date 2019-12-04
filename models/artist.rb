require('pg')
require_relative('../db/sql_runner')

class Artist

  attr_reader :id
  attr_accessor :name

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO artists (
      name
    ) VALUES ($1) RETURNING id;"
    values = [@name]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM artists;"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM artists;"
    results = SqlRunner.run(sql)
    artists = results.map { |artist| Artist.new(artist) }
    return artists
  end

  def find_albums()
    sql = "SELECT * FROM albums WHERE artist_id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    albums = results.map { |album| Album.new(album) }
    return albums
  end

  def update()
    sql = "UPDATE artists SET name = $1 WHERE id = $2;"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete_one()
    sql = "DELETE FROM albums WHERE artist_id = $1;"
    sql2 = "DELETE FROM artists WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
    SqlRunner.run(sql2, values)
  end

end
