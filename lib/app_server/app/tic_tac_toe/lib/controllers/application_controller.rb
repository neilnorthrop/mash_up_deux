class ApplicationController
	attr_accessor :session, :params

  def initialize(params)
    @params = params
  end

	def run
		raise "CREATE THIS METHOD"
	end
end
