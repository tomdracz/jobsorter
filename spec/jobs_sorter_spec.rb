require 'jobs_sorter'

describe JobsSorter do
  let(:jobs_sorter) { JobsSorter.new(jobs) }

  describe "#parse" do
    let(:jobs) { "a =>  b =>  c =>" }

    it "converts jobs string into a hash" do
      expect(jobs_sorter.parse(jobs)).to eql({"a" => "", "b" => "", "c" => ""})
    end
  end

  describe "jobs sorting" do
    before(:each) do
      jobs_sorter.sort
    end

    context "when given an empty string" do
      let(:jobs) { "" }

      it "returns an empty array" do
        expect(jobs_sorter.results).to eql([])
      end

      it "should have zero elements" do
        expect(jobs_sorter.results.size).to eql(0)
      end
    end

    context "when given one job" do
      let(:jobs) { "a =>" }

      it "returns an array with one job" do
        expect(jobs_sorter.results).to eql(["a"])
      end

      it "should have one element in results" do
        expect(jobs_sorter.results.size).to eql(1)
      end
    end

    context "when given a list of three jobs without dependencies" do
      let(:jobs) { "a =>  b =>  c =>"  }

      it "returns an array with three jobs" do
        expect(jobs_sorter.results).to eql(["a", "b", "c"])
      end

      it "should have 3 elements in results" do
        expect(jobs_sorter.results.size).to eql(3)
      end
    end

    context "when given a list of three jobs with one dependency" do
      let(:jobs) { "a =>  b => c c =>"  }

      it "returns an array with three jobs in a correct order" do
        expect(jobs_sorter.results).to eql(["a", "c", "b"])
      end

      it "should have 3 elements in results" do
        expect(jobs_sorter.results.size).to eql(3)
      end
    end

    context "when given a list of six jobs with multiple dependencies" do
      let(:jobs) { "a =>  b => c c => f d => a e => b f =>"  }

      it "returns an array with six jobs in a correct order" do
        expect(jobs_sorter.results).to eql(["a", "f", "c", "b", "d", "e"])
      end

      it "should have 6 elements in results" do
        expect(jobs_sorter.results.size).to eql(6)
      end
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
