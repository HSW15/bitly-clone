class Url < ActiveRecord::Base
	validates :long_url, uniqueness: true
	validates :long_url, format: {with: (URI::regexp(['http', 'https'])), message: "invalid"}

end
