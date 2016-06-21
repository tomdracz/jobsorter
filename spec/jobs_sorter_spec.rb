require 'jobs_sorter'

describe JobsSorter do
  let(:jobs_sorter) { JobsSorter.new(jobs) }

  describe "#parse" do
    let(:jobs) { "a =>  b =>  c =>" }

    it "converts jobs string into a hash" do
      expect(jobs_sorter.parse(jobs)).to eql({"a" => "", "b" => "", "c" => ""})
    end
  end
end
