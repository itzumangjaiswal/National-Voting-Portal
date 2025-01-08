# Voting System Project

## Introduction
The Voting System project is part of a full-stack Java training, designed to simulate the experience of organizing and participating in elections. The project includes three main roles: Admin, Sub Admins, and Voters. Each role has specific tasks, from managing elections and candidates to the voting process itself.

## Features

### Admin Roles:
- Admin credentials (username and password) are stored in the database.
- Admins can log in and create different types of elections:
  - Rajya Sabha elections
  - Lok Sabha elections
  - Municipal Corporation elections
- Admins can assign sub-admins to manage specific elections.
  
### Sub Admins:
- Sub Admins can manage elections assigned by the Admin.
- They can log-in and view a list of candidates for the election.
- Sub Admins can add new candidates, providing details like:
  - Full Name
  - Date of Birth
  - Nationality
  - Party Name
  - Party Logo 
- Candidates must be 35 years or older and Indian nationals to be added.
- Sub Admins can modify candidate details but cannot change the candidate's age or vote count.

### Voter Roles:
- Voters can register with their details:
  - Name, Date of Birth, Phone Number, Aadhar Number, Password, and Nationality.
- Only one voter can register with the same Aadhar number.
- Only voters who are 18 years or older and Indian citizens can register.
- After registering, voters receive a Voter ID.
- Voters can log in and view ongoing elections.
- Only ongoing elections are available for voting.
- Voters can cast their vote, selecting a candidate from a list that includes:
  - Candidate Name
  - Party Name
  - Party Logo
- Voters must confirm their vote through a pop-up, and they can only vote once.
- Once a voter casts their vote, they are marked as having voted and cannot vote again.

### Candidate Management:
- When a candidate is first added, their vote count is set to 0.
- Each vote increases the candidate's vote count by 1.
  
### Voter Status:
- Once a voter has voted, their status is updated, and they cannot vote again.
- The system will redirect them to a message saying, "You have already voted" if they try to log in again.

---

## Technologies Used
- **Frontend**: HTML, CSS, JavaScript
- **Backend**: Java (Spring Boot)
- **Database**: MySQL or any relational database
- **Version Control**: Git and GitHub

 

 
