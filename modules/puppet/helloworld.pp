class puppet::helloworld {
  
  $helloworld = "Can't Stop Believing..."

  notice("cant stop wont stop never belivin in my self. ${helloworld}")
  notify{"cant stop wont stop never belivin in my self again. ${helloworld}": }
}