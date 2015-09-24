require 'spec_helper'

describe group('mysql') do
  it { should exist }
end

describe user('mysql') do
  it { should exist }
end
