# frozen_string_literal: true

User.create(id: 1, username: 'Muhammad Fahad Akbar', email: 'fahad.akbar@devsinc.com', user_type: 'Manager', password: '123123')
User.create(id: 2, username: 'Ghulam Ali Butt', email: 'ali@gmail.com', user_type: 'Manager', password: '123123')
User.create(id: 3, username: 'Muhammad Hamad Akbar', email: 'hamad@gmail.com', user_type: 'Developer', password: '123123')
User.create(id: 4, username: 'Hassan Mujtaba', email: 'hassan@gmail.com', user_type: 'Developer', password: '123123')
User.create(id: 5, username: 'Usama Bin Sabir', email: 'usama@gmail.com', user_type: 'QA', password: '123123')
User.create(id: 6, username: 'Rai Atif Ali', email: 'atif@gmail.com', user_type: 'QA', password: '123123')

Rails.logger.debug '6 Users have been added successfully'

Project.create(id: 1, title: 'Project By Fahad', description: 'This project was added by the manager Fahad')
Project.create(id: 2, title: 'Project By Ali', description: 'This project was added by the manager Ali')

Rails.logger.debug '2 Projects have been added successfully'

Prouse.create(id: 1, project_id: 1, user_id: 1)
Prouse.create(id: 2, project_id: 2, user_id: 2)

Rails.logger.debug '2 Users and Project have been Linked'
