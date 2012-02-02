#/usr/bin/ruby -w

require 'ldap'

username 	= #{params[:username]}
currentpassword = #{params[:currentPassword]}
newpassword	= #{params[:newPassword]}

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
    raise
    exit
  conn.unbind
  end
end
