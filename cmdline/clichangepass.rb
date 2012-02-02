#/usr/bin/ruby -w


#arguments UserName CurrentPassword NewPassword 
username        = ARGV[0].to_s
currentpassword = ARGV[1].to_s
newpassword     = ARGV[2].to_s

if ARGV.length < 1
  puts "clichangepass.rb UserName CurrentPassword NewPassword"
  exit
end

require 'ldap'

$HOST =    'localhost'
$PORT =    LDAP::LDAP_PORT

LDAP::Conn.set_option(LDAP::LDAP_OPT_PROTOCOL_VERSION, 3 )


def changepass(username, currentpassword, newpassword)
  conn = LDAP::Conn.new($HOST, $PORT)
  conn.bind("uid=#{username}, ou=people, dc=steeprockinc, dc=com","#{currentpassword}")
  changepw=[LDAP::Mod.new(LDAP::LDAP_MOD_REPLACE, 'userPassword', ["#{newpassword}"]),]
  begin
    conn.modify("uid=#{username}, ou=people, dc=steeprockinc, dc=com", changepw)
  rescue LDAP::ResultError
    conn.perror("modify")
    exit
  conn.unbind
  end
end

puts "#{username}"
puts "#{currentpassword}"
puts "#{newpassword}"

changepass("#{username}", "#{currentpassword}", "#{newpassword}")
