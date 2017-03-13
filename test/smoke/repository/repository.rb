# # encoding: utf-8

# Inspec test for recipe mongo::repository

if os.debian?
  describe apt("https://repo.mongodb.org/apt/#{os.name}") do
    it { should exist }
    it { should be_enabled }
  end
end

if os.redhat?
  describe yum.repo('mongodb-3.4') do
    it { should exist }
    it { should be_enabled }
  end
end
