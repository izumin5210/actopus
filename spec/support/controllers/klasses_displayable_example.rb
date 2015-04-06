shared_examples_for 'klasses displayable' do
  it_behaves_like 'klasses index displayable'
  it_behaves_like 'klasses timetable displayable'
end

shared_examples_for 'klasses index displayable' do
  let!(:klasses) { create_list(:klass, 5) }
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
  create_term_and_freeze_time
  let!(:klasses) { create_list(:klass, 5) }
  let(:params) { { id: klasses[0].slug } }

  describe 'GET timetable' do
    let!(:lectures) { create_list(:lecture, 5, term: term, klass: klasses[0]) }
    before { get :timetable, params }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'assigns the klass\'s lecture to @lectures' do
      expect(assigns(:lectures)).to match_array(lectures)
    end
  end
end
