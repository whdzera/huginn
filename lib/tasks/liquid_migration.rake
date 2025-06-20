namespace :huginn do
  desc "Convert agents to Liquid templating format"
  task migrate_to_liquid: :environment do
    require 'liquid_migrator'

    agents = {
      'Agents::HipchatAgent' => [],
      'Agents::PushbulletAgent' => [],
      'Agents::JabberAgent' => [],
      'Agents::DataOutputAgent' => [],
      'Agents::HumanTaskAgent' => [],
    }

    agents.each do |type, _|
      Agent.where(type: type).find_each do |agent|
        LiquidMigrator.convert_all_agent_options(agent)
      end
    end

    Agent.where(type: 'Agents::EventFormattingAgent').find_each do |agent|
      agent.options['instructions'] = LiquidMigrator.convert_hash(agent.options['instructions'], merge_path_attributes: true, leading_dollarsign_is_jsonpath: true)
      agent.save!
    end

    Agent.where(type: 'Agents::TranslationAgent').find_each do |agent|
      agent.options['content'] = LiquidMigrator.convert_hash(agent.options['content'], merge_path_attributes: true, leading_dollarsign_is_jsonpath: true)
      agent.save!
    end

    Agent.where(type: 'Agents::TwitterPublishAgent').find_each do |agent|
      if (message = agent.options.delete('message_path')).present?
        agent.options['message'] = "{{#{message}}}"
        agent.save!
      end
    end

    Agent.where(type: 'Agents::TriggerAgent').find_each do |agent|
      agent.options['message'] = LiquidMigrator.convert_make_message(agent.options['message'])
      agent.save!
    end

    Agent.where(type: 'Agents::PeakDetectorAgent').find_each do |agent|
      agent.options['message'] = LiquidMigrator.convert_make_message(agent.options['message'])
      agent.save!
    end

    puts "✅ Done converting agents to Liquid templating format."
  end
end
