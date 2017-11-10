class freeipa(
)
{
	exec{ 'remove-dns-host-record':
		command => "/bin/sed '/host/d' /etc/resolv.conf",
		before => Exec['ipa-server-install'];
	}
	package { ['firewalld','bind','bind-dyndb-ldap','ipa-server','ipa-server-dns']:
		ensure => latest,
		before => Exec['ipa-server-install'];
	}
	exec { 'ipa-server-install':
		command	=> "/usr/sbin/ipa-server-install -r TEST.KING -n test.king -p King@1512 -a King@1512 --setup-dns --auto-forwarders --hostname=freeipa.test.king --no-reverse --no-dnssec-validation -U",
		timeout => 600,	
		unless	=> '/usr/bin/[ -f /etc/ipa/default.conf ]';
	}
	service { 'firewalld':
		ensure => running,
		require => Package['firewalld'];
	}
	exec { 'open-ipa-port':
		command => "/usr/bin/firewall-cmd --add-service={ssh,dns,freeipa-ldap,freeipa-ldaps} --permanent;/usr/bin/firewall-cmd --reload ",
		require => Service['firewalld'];
	}
}

