# Challenge
# Valid parentheses

# Description
# Write a function called that takes a string of parentheses, and determines if the order of the
# parentheses is valid. The function should return true if the string is valid, and false if it’s
# invalid

# Examples
# “()”   => true
# “)(()))”  => false
# “(“  => false
# “(((())))”.  => true 

# Constraints
# 0 <= string.length <= 100 

# Along with opening (() and closing ()) parenthesis, input may contain any valid ASCII characters.
# Furthermore, the input string may be empty and/or not contain any parentheses at all.
# Do not treat other forms of brackets as parentheses (e.g. [], {}, <>.

require_relative 'challenge_1'

RSpec.describe Validator do
  subject { described_class.valid_parenthesis?(test_string) }

  context 'nil input' do
    let(:test_string) { nil }
    it { is_expected.to eq 'Invalid input' }
  end

  context 'unclosed parenthesis' do
    let(:test_string) { ' (' }
    it { is_expected.to be false }
  end

  context 'unopened parenthesis' do
    let(:test_string) { ')test' }
    it { is_expected.to be false }
  end

  context 'blank string' do
    let(:test_string) { '' }
    it { is_expected.to be true }
  end

  context 'wrong order for parenthesis' do
    let(:test_string) { 'hi())(' }
    it { is_expected.to be false }
  end

  context 'ordered parenthesis' do
    let(:test_string) { 'hi(hi)()' }
    it { is_expected.to be true }
  end

  context '[] order is irrelevant' do
    let(:test_string) { '[](])' }
    it { is_expected.to be true }
  end

  context '{} order is irrelevant' do
    let(:test_string) { '*(!)(*}})>' }
    it { is_expected.to be true }
  end

  context 'too long of an input' do
    let(:test_string) do
      '(1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890)'
    end
    it { is_expected.to eq 'Invalid input' }
  end
end
