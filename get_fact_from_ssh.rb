# get_fact_ssh.rb
# Example Output =
# Management


    Facter.add('ssh_fact') do
      setcode do
        Facter::Core::Execution.exec("ssh -q -o PasswordAuthentication=no -o ConnectionAttempts=1 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i /var/lib/puppet/lib/facter/$ssh_rsa_key $user@$sshtarget /home/$user/bin/ssh_fact $(hostname)")
      end
    end
