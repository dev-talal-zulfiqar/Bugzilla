# frozen_string_literal: true

User.create(name: 'Talal developer', email: 'talal.developer@gmail.com', role: 'developer', password: '123456')
User.create(name: 'Talal manager', email: 'talal.manager@gmail.com', role: 'manager', password: '123456')
User.create(name: 'Talal Quality Assured', email: 'talal.qa@gmail.com', role: 'software_quality_assurance',
            password: '123456')

Project.create(title: 'Dummy Project 1', description: 'This is seed Project created by talal.manager', user_id: '2')
Project.create(title: 'Dummy Project 2', description: 'This is seed Project created by talal.manager', user_id: '2')

Bug.create(title: 'Demo Bug 1', description: 'description for Bug', bug_type: 'bug', status: 'opened',
           created_by_id: '3', project_id: '1')
Bug.create(title: 'Demo Bug 2', bug_type: 'bug', status: 'opened', created_by_id: '3', project_id: '1')
Bug.create(title: 'Demo Bug 1', description: 'description for Bug', bug_type: 'bug', status: 'opened',
           created_by_id: '3', project_id: '2')
Bug.create(title: 'Demo Bug 2', bug_type: 'bug', status: 'opened', created_by_id: '3', project_id: '2')

ProjectsUser.create(user_id: 1, project_id: 1)
ProjectsUser.create(user_id: 1, project_id: 2)
