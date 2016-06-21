require 'jobs_sorter'

describe JobsSorter do
  let(:jobs_sorter) { JobsSorter.new(jobs) }

  describe "#parse" do
    let(:jobs) { "a =>  b =>  c =>" }

    it "converts jobs string into a hash" do
      expect(jobs_sorter.parse(jobs)).to eql({"a" => "", "b" => "", "c" => ""})
    end
  end

  describe "dependency errors" do
    context "when given a string with self dependency error" do
      let(:jobs) { "a => b c => c"}

      it "raises a self dependency error" do
        expect{jobs_sorter}.to raise_error(JobsSorter::SelfDependencyError)
      end
    end
  end
end
