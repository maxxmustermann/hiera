class hiera ($ensure = 'installed', $content = undef, $symlink = false) {
    package {'hiera':
        ensure => $ensure
    }
    
    if $content != undef {
        file { '/etc/hiera.yaml':
            path   => '/etc/hiera.yaml',
            owner  => root,
            group  => root,
            mode   => 0644,
            content => $content
        }
    }
    
    if $symlink == true {
        file { '/etc/puppet/hiera.yaml':
            ensure => link,
            target => '/etc/hiera.yaml'
        }
    }
}
