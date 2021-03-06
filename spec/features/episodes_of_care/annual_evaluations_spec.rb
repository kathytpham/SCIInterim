include Warden::Test::Helpers
Warden.test_mode!

# Feature: Annual Evaluations
#   As a user
#   I want to add or edit annual evalutions per patient
#   So I can properly record this type of episode of care
feature 'Annual Evaluations' do
  after(:each) do
    Warden.test_reset!
  end

  # Scenario: Add Annual Evaluation to a patient
  #   Given I am a user
  #   When I add an Annual Evaluation to a patient record
  #   Then return to the patient record and can see the newly created Annual
  #        Evaluation
  scenario 'Add Annual Evaluation' do
    sign_in_user
    patient1 = create(:patient)
    visit edit_patient_path(patient1)

    expect(page).to have_content "Basic Patient Info"
    expect(page).to have_content patient1.ssn

    click_link("Annual Eval")
    expect(page).to have_content "New Annual Evaluation"

    fill_in "Episode Date", with: Time.now

    click_button("Create Annual evaluation")
    current_url.should == edit_patient_url(patient1)

    # TODO(awong.dev): Verify annual evaluation shows.
  end
end
