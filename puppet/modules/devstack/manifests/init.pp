class devstack (
  $dir = '/home/vagrant/devstack'
)
{
  #$user = $user::stack::username
  $source = 'https://github.com/openstack-dev/devstack'
  $branch = 'stable/icehouse'

  exec { "cloning_devstack":
    require => File["/usr/local/bin/git.sh"],
    path => "/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:.",
    environment => "HOME=/home/vagrant",
    user => 'vagrant',
    group => 'vagrant',
    command => "/usr/local/bin/git.sh ${source} ${branch} ${dir}",
    logoutput => true,
  }

  file {"$dir/local.conf":
    owner => vagrant,
    group => vagrant,
    mode => 644,
    content => template("devstack/local.erb"), 
  }
  
  exec {"stack.sh":
    require => File["$dir/local.conf"],
    cwd => $dir,
    path => "/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:.",
    environment => "HOME=/home/vagrant",
    user => 'vagrant',
    group => 'vagrant',
    command => "$dir/stack.sh",
    logoutput => true,
    timeout => 0
  }

}
