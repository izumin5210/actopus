shared_examples_for 'klasses displayable' do
  it_behaves_like 'klasses index displayable'
  it_behaves_like 'klasses timetable displayable'
end

shared_examples_for 'klasses index displayable' do
  let!(:klasses) { create_list(:klass, 5, :with_department) }
  let(:params) { {} }

  describe 'GET index' do
    before { get :index, params }
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'assigns klasses to @klasses' do
      expect(assigns(:klasses)).to match_array(klasses)
    end
  end
end

shared_examples_for 'klasses timetable displayable' do
  let!(:klasses) { create_list(:klass, 5, :with_department) }
  let(:params) { { id: klasses[0].slug } }

  describe 'GET timetable' do
    let(:started_on) { Date.new(2014, 10, 1) }
    let(:ended_on) { Date.new(2015, 2, 28) }
    let(:term) { create(:academic_term, started_on: started_on, ended_on: ended_on) }
    let!(:lectures) { create_list(:lecture, 5, term: term, klass: klasses[0]) }
    before do
      Timecop.freeze(Time.local(2015, 1, 19, 12, 0, 0))
      get :timetable, params
    end
    after { Timecop.return }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'assigns the klass\'s lecture to @lectures' do
      expect(assigns(:lectures)).to match_array(lectures)
    end
  end
end
