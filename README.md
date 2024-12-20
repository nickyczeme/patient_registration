# Patient Registration API

This repository implements a patient registration API using Ruby on Rails. It adheres to RESTful API principles, validates user input, includes asynchronous email notificacions and provides containerized development environment with Docker. 

## Setup Instructions 
1. Clone the Repository
```bash
git clone https://github.com/nickyczeme/patient_registration/
cd patient_registration
```
2. Build Docker Environment
```bash
docker-compose build
```
3. Start the Application
```bash
docker-compose up
```
4. Set Up the Database
```bash
docker-compose run web rails db:create db:migrate
```
To Stop the Containers
```bash
docker-compose down
```

## API Implementation 
- Endpoint: ```POST /api/v1/patients```
- Request example using ```curl```
```bash
curl -X POST http://localhost:3000/api/v1/patients \
  -F "name=John Smith" \
  -F "email=smith@gmail.com" \
  -F "phone=1122334455" \
  -F "document_photo=@./faq1.png"
```
- Response:
  - 201 Created: Returns the patient's information in JSON format.
  - 422 Unprocessable Entity: Returns validation errors if the input data is invalid.
 
## Tests
The application includes tests to verify API functionality. To run the tests:
```bash
docker-compose run web bundle exec rails test
```

## Functionalities Details
1. API design
- Built with Rails RESTful architecture
- Endpoint: ```POST /api/v1/patients```
- Collects the following information:
  - Name
  - Email address
  - Phone number
  - Photo of a document (attachment)

2. Data validation
- Ensures the presence of name, email and phone number.
- Validates the email formal.
  Invalid requests return 422 with the error messages.
- Future implementation: Include phone number validation based on country codes.

3. Database
- SQLite was used because of installation challenges with MySQL.
-Patient Table Schema:
  - name (string)
  - email (string)
  - phone (string)
  - document_photo (Active Storage)
- Note: for production, MySQL would be implemented.

4. Asynchronous Email
- Confirmation emails are sent using Action Mailer and Active Job.
- Letter Opener is configured in development to preview emails in the browser.
To Simulate Email Sending:
  1. Open the Rails console:
     ```bash
     docker-compose run web rails console
     ```
  2. Trigger an email for the last created patient:
     ```bash
     PatientMailer.with(patient: Patient.last).confirmation_email.deliver_now
     ```
  3. Preview the email
     ```bash
     open tmp/letter_opener/<email_file_name>.html
     ```

5. Docker
The project is containerized using Docker Compose

6. SMS Notification
A placeholder service (SmsNotificationService) is implemented for future SMS notifications.

