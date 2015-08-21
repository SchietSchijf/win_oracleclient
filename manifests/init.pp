# Class: win_oracleclient
#
# This module manages win_oracleclient
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class win_oracleclient ($p_software_repo = $global_software_repo_path, $p_oracle_installer = 'setup.exe', $p_responseFile_path,) {
#  file { 'create responsefile':
#    ensure  => file,
#    content => 'testje',
#    path    => 'C:\oracle\product\11.2.0\client_1\network\admin\test.txt',
#  }

  exec { 'Oracle Client 11.2.0.4':
    command  => "\"${p_software_repo}\\${p_oracle_installer}\" -silent -waitforcompletion -noconsole -responseFile ${p_responseFile_path}",
    creates  => 'C:\oracle\product\11.2.0\client_1\bin\sqlplus.exe',
    provider => windows,
    #require  => File['create responsefile'],
  }

  file { 'create tnsnames.ora':
    ensure  => file,
    path    => 'C:\oracle\product\11.2.0\client_1\network\admin\tnsnames.ora',
    require => Exec['Oracle Client 11.2.0.4'],
  }

#  exec { 'delete responsfile':
#    command  => 'C:\windows\system32\cmd.exe /C "del C:\oracle\product\11.2.0\client_1\network\admin\test.txt"',
#    provider => windows,
#    require  => Exec['Oracle Client 11.2.0.4'],
#  }
}
