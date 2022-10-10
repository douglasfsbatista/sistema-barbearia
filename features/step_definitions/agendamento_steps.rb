Given('um cliente cadastrado com nome {string}  telefone {string}  email {string} data_nascimento {string} existe') do |nome, telefone, email, data_nascimento|
  visit '/clientes/new'
  fill_in 'cliente[nome]', :with => nome
  fill_in 'cliente[telefone]', :with => telefone
  fill_in 'cliente[email]', :with => email
  fill_in 'cliente[data_nascimento]', :with => data_nascimento
  click_button 'Create Cliente'
end

Then('existe um barbeiro com o nome {string}  cpf {string}  data_nascimento {string}  telefone {string}  email {string}') do |nome, cpf, data_nascimento, telefone, email|
  visit '/barbeiros/new'
  fill_in 'barbeiro[nome]', :with => nome
  fill_in 'barbeiro[cpf]', :with => cpf
  fill_in 'barbeiro[data_nascimento]', :with => data_nascimento
  fill_in 'barbeiro[telefone]', :with => telefone
  fill_in 'barbeiro[email]', :with => email
  click_button 'Create Barbeiro'
end

And('existe um servico com o nome {string} valor {string} e tempo {string}') do |nome, valor, tempo|
  visit '/services/new'
  fill_in 'service[nome]', :with => nome
  fill_in 'service[valor]', :with => valor
  fill_in 'service[tempo]', :with => tempo
  click_button 'Create Service'
end
When('eu estou na pagina de clientes e aperto no cliente com nome {string}') do |nome|
  visit "/clientes"
  cliente = Cliente.find_by nome: nome
  visit "/clientes/" + cliente.id.to_s
end

Then('eu seleciono o barbeiro {string} o servico {string} e o inicioAtendimento {string}') do |barbeiro,servico, inicioAtendimento|
  select barbeiro, :from => 'agendamento_barbeiro_id'
  select servico, from => 'agendamento_service_id'
  fill_in 'agendamento_inicioAtendimento', with:  inicioAtendimento

end

When('eu clico em Create Agendamento') do
  click_on 'Create Agendamento'

end

Then('eu vejo uma mensagem de confirmacao do sistema {string}') do |text|
  page.has_text?(text)
end


Then('eu seleciono o servico {string} o inicioAtendimento {string}') do |servico,inicioAtendimento|
  select servico, from => 'agendamento_service_id'
  fill_in 'agendamento_inicioAtendimento', with:  inicioAtendimento

end

When('eu clico no Create Agendamento') do

  page.should_not have_content('agendamento_barbeiro_id')

end
Then('eu vejo uma mensagem de erro {string}') do |text|
  page.has_text?(text)
end

Then('eu seleciono o barbeiro {string} e o inicioAtendimento {string}') do |barbeiro, inicioAtendimento|
  select barbeiro, :from => 'agendamento_barbeiro_id'
  fill_in 'agendamento_inicioAtendimento', with:  inicioAtendimento
end

When('eu clico no Create Agendamento') do

  page.should_not have_content('agendamento_service_id')

end

Then('eu vejo uma mensagem de erro {string}') do |text|
  page.has_text?(text)
end
