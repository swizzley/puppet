# get_sysid.rb
# Example Output =
# Management


    Facter.add('get_sysid') do
      setcode do
        Facter::Core::Execution.exec("grep ID- /etc/sysconfig/rhn/systemid|cut -c 19-28")
      end
    end


