node "wiki" {
#  $wikisitename = 'wiki'
#  $wikimetanamespace = 'wiki'
#  $wikiserver = 'http://172.31.0.202'
#  $wikidbserver = 'localhost'
#  $wikidbname = 'wiki'
#  $wikidbpassword = 'training'
#  $wikidbuser = 'root'
#  $wikiupgradekey = 'puppet'
#  class {'linux': }
#  class {'mediawiki': }
  hiera_include('classes')
}

node "wikitest" {

  hiera_include('classes')
  # $wikisitename = 'wiki'
  #$wikimetanamespace = 'wiki'
  #$wikiserver = 'http://172.31.0.203'
  #$wikidbserver = 'localhost'
  #$wikidbname = 'wiki'
  #$wikidbpassword = 'training'
  #$wikidbuser = 'root'
  #$wikiupgradekey = 'puppet'
  #class {"linux": }
  #class {'mediawiki': }
}

class linux {

  $ntpservice = $osfamily ? {
    "redhat" => "ntpd",
    "debian" => "ntp",
    "default" => "ntp",
  }

  $packages = ['git', 'vim-common', 'screen']

  file { "/info.txt":
    ensure => 'present',
    content => inline_template ("Created by Puppet at <%= Time.now %> \n"),
  }

  package { $packages: #"ntp":
    ensure => 'installed',
  }

  service { $ntpservice: #"ntpd":
    ensure => 'running',
    enable => true,
  }
}
