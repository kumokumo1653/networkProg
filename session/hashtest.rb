require 'digest/sha1'
require 'digest/sha2'
require 'digest/md5'

s = "Roads? Where We are going, we don't need, roads"
puts s
puts Digest::SHA1.digest(s)
puts Digest::SHA1.hexdigest(s)
puts Digest::SHA256.digest(s)
puts Digest::SHA256.hexdigest(s)
puts Digest::SHA384.digest(s)
puts Digest::SHA384.hexdigest(s)
