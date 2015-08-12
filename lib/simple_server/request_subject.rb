module RequestSubject
  def initialize
    @observers = []
  end

  def add_observer(observer)
    @observers << observer
  end

  def delete_observer(observer)
    @observers.delete(observer)
  end

  def notify_observers(request)
    @observers.each do |observer|
      return observer.notify(request)
    end
  end
end
