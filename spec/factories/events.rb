FactoryGirl.define do
  factory :event do
    title "Event title"
    description "Event description"
    start_time DateTime.new(2018,1,10,4,5,6,'+02:00')
    end_time DateTime.new(2018,2,15,4,5,6,'+02:00')

    before(:create) do |event|
      event.user = create(:user)
      event.save
    end
  end
end
