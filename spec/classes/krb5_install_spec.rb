require 'spec_helper'
 
describe 'krb5::install', :type => 'class' do
   
  context "Should install required packages " do
    let(:facts){{:operatingsystem => "CentOS"}}
    let(:params){{'absent' => false}}
    it do
      
      should contain_package('krb5-libs').with_ensure('present')
      should contain_package('krb5-workstation').with_ensure('present')
      should contain_package('pam_krb5').with_ensure('present')
    end
  end
  context "Should uninstall packages in case absent param is set" do
    let(:facts){{:operatingsystem => "CentOS"}}
    let(:params){{'absent' => true}}
    it do
      
      should contain_package('krb5-libs').with_ensure('absent')
      should contain_package('krb5-workstation').with_ensure('absent')
      should contain_package('pam_krb5').with_ensure('absent')
    end
  end
  context "Should fail in case it is not centos" do
    let(:facts){{:operatingsystem => "notsupported"}}
    it { expect { should contain_class('krb5::install') }.to raise_error(Puppet::Error) }
  end
end
