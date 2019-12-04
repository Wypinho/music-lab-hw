require('pry')
require_relative('../models/artist')
require_relative('../models/album')

artist1 = Artist.new ({
  'name' => "Metallica"
  })
artist1.save()

artist2 = Artist.new ({
  'name' => "Paul Simon"
  })
artist2.save()

binding.pry
nil
