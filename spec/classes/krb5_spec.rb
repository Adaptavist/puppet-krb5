require 'spec_helper'
 
describe 'krb5', :type => 'class' do
    
  context "Should fail in case it is not centos" do
    let(:facts){{:operatingsystem => "notsupported"}}
    it { expect { should contain_class('krb5') }.to raise_error(Puppet::Error) }

  end

  context "Should include prerequisites before krb5 class " do
    let(:facts){{:operatingsystem => "CentOS"}}
    it do
      should contain_class('krb5::install').that_comes_before("Class[krb5::config]")
      should contain_class('krb5::config').that_notifies("Class[krb5]")
    end

  end
end
