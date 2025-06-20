namespace :huginn do
  desc "Convert EventFormattingAgents based on skip_agent flag"
  task convert_efa_skip_agent: :environment do
    puts "⏳ Converting EventFormattingAgent agents..."

    Agent.where(type: 'Agents::EventFormattingAgent').find_each do |agent|
      begin
        agent.options_will_change!
        unless agent.options.delete('skip_agent').to_s == 'true'
          agent.options['instructions'] = {
            'agent' => '{{agent.type}}'
          }.merge(agent.options['instructions'] || {})
        end
        agent.save!
      rescue => e
        puts "❌ Failed to convert agent ID #{agent.id}: #{e.message}"
      end
    end

    puts "✅ Done converting EventFormattingAgents"
  end

  desc "Convert WebsiteAgents from legacy text/attr to value key"
  task adopt_xpath_in_website_agent: :environment do
    puts "⏳ Converting WebsiteAgent extract config..."

    Agent.where(type: 'Agents::WebsiteAgent').find_each do |agent|
      begin
        extract = agent.options['extract']
        next unless extract.is_a?(Hash) && extract.all? { |_, detail| detail.key?('xpath') || detail.key?('css') }

        agent.options_will_change!

        agent.options['extract'].each do |_, extraction|
          case
          when extraction.delete('text')
            extraction['value'] = 'string(.)'
          when (attr = extraction.delete('attr'))
            extraction['value'] = "@#{attr}"
          end
        end

        agent.save!
      rescue => e
        puts "❌ Error on agent #{agent.id}: #{e.message}"
      end
    end

    puts "✅ Finished converting WebsiteAgents"
  end

end
