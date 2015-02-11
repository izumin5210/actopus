shared_examples_for 'lecturers displayable' do
  it_behaves_like 'lecturers index displayable'
  it_behaves_like 'lecturers timetable displayable'
end

shared_examples_for 'lecturers index displayable' do
  let(:department) { create(:department) }
  let!(:lecturers) { create_list(:lecturer, 5, department: department) }
  let(:params) { {} }

  describe 'GET index' do
    before { get :index, params }
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'assigns lecturers grouped by department ids to @lecturers' do
      expect(assigns(:lecturers)).to match(department.id => lecturers)
    end
  end
end

shared_examples_for 'lecturers timetable displayable' do
  let(:department) { create(:department) }
  let!(:lecturer) { create(:lecturer, department: department) }
  let(:params) { { id: lecturer.id } }

  describe 'GET timetable' do
    let(:started_on) { Date.new(2014, 10, 1) }
    let(:ended_on) { Date.new(2015, 2, 28) }
    let(:term) do
      create(:academic_term, started_on: started_on, ended_on: ended_on)
    end
    let!(:lectures) do
      create_list(:lecture, 5, :with_klass, term: term).tap { |l| lecturer.lectures = l }
    end
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
