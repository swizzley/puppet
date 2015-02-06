# get_changeme_environment.rb
# Example Output =
# Management


    Facter.add('changeme_environment') do
      setcode do
        Facter::Core::Execution.exec("ssh -q -o PasswordAuthentication=no -o ConnectionAttempts=1 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i /var/lib/puppet/lib/facter/rsa_key $USER@$PUPPETMASTER /home/$USER/bin/get_spacealk_environment $(hostname)")
      end
    end

