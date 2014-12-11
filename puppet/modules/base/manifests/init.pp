class base {

  package {"git":
    ensure => latest
  }


  file {"/usr/local/bin/git.sh":
    owner => "root",
    group => "root",
    mode => 755,
    source => "puppet:///modules/base/git.sh",
    require => Package["git"]
  }


}
