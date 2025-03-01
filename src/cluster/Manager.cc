// See the file "COPYING" in the main distribution directory for copyright.

#include "zeek/cluster/Manager.h"

#include "zeek/cluster/Serializer.h"

using namespace zeek::cluster;

Manager::Manager()
    : backends(plugin::ComponentManager<BackendComponent>("Cluster", "BackendTag")),
      event_serializers(plugin::ComponentManager<EventSerializerComponent>("Cluster", "EventSerializerTag")),
      log_serializers(plugin::ComponentManager<LogSerializerComponent>("Cluster", "LogSerializerTag")) {}

std::unique_ptr<Backend> Manager::InstantiateBackend(
    const zeek::EnumValPtr& tag, std::unique_ptr<EventSerializer> event_serializer,
    std::unique_ptr<LogSerializer> log_serializer,
    std::unique_ptr<detail::EventHandlingStrategy> event_handling_strategy) {
    if ( const auto* c = Backends().Lookup(tag) )
        return c->Factory()(std::move(event_serializer), std::move(log_serializer), std::move(event_handling_strategy));

    return nullptr;
}

std::unique_ptr<EventSerializer> Manager::InstantiateEventSerializer(const zeek::EnumValPtr& tag) {
    const EventSerializerComponent* c = EventSerializers().Lookup(tag);
    return c ? c->Factory()() : nullptr;
}

std::unique_ptr<LogSerializer> Manager::InstantiateLogSerializer(const zeek::EnumValPtr& tag) {
    const LogSerializerComponent* c = LogSerializers().Lookup(tag);
    return c ? c->Factory()() : nullptr;
}
