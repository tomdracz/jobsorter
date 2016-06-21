class JobsSorter
  class SelfDependencyError < StandardError
  end

  attr_reader :results

  def initialize(jobs)
    @jobs_hash = parse(jobs)
    @results = []
  end

  def parse(job_string)
    jobs_hash = job_string.scan(/([a-z]) => ?([a-z]?)/).to_h
    has_self_dependency?(jobs_hash)
    return jobs_hash
  end

  def sort!
    if @jobs_hash.empty?
      @results = []
    elsif @jobs_hash.values.reject(&:empty?).empty?
      @results = @jobs_hash.keys
    else

    end
    @results
  end

  private

  def has_self_dependency?(jobs_hash)
    jobs_hash.each do |k,v|
      raise SelfDependencyError, "self dependency detected" if k == v
    end
  end
end
