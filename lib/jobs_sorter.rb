class JobsSorter
  attr_reader :results

  def initialize(jobs)
    @jobs_hash = parse(jobs)
    @results = []
  end

  def parse(job_string)
    jobs_hash = job_string.scan(/([a-z]) => ?([a-z]?)/).to_h
    return jobs_hash
  end
end
