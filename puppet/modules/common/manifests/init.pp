class common () {
#	file { '/etc/resolv.conf':
#		ensure	=> present,
#		content	=> "nameserver 172.17.0.2";
#	}
	package {'ipa-client':
		ensure	=> latest;
	}
	exec {'change-resolv-config':
		command => "/usr/bin/echo 'nameserver 172.17.0.2'>/etc/resolv.conf",
		unless	=> "/usr/bin/cat /etc/resolv.conf|grep '172.17.0.2'>/dev/null";
	}
	exec {'ipa-client-install':
		command	=> "/usr/sbin/ipa-client-install -w $(cat /etc/freeipa_pass) -U",
		require => Exec['change-resolv-config'];
	}
	
}
