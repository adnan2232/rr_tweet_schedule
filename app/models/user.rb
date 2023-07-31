#db columns
#email:string
#password_digest:strinf
#
#virtual columns 
#password: string
#password_confirmation:string
class User < ApplicationRecord
    has_secure_password
    validates :email, presence: true, format: {with:/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, message:"email doesn't match the pattern"}
end
