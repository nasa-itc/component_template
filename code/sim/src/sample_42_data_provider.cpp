#include <ItcLogger/Logger.hpp>

#include <sample_data_point.hpp>

#include <sample_42_data_provider.hpp>

namespace Nos3
{
    REGISTER_DATA_PROVIDER(Sample42DataProvider,"SAMPLE_42_PROVIDER");

    extern ItcLogger::Logger *sim_logger;

    Sample42DataProvider::Sample42DataProvider(const boost::property_tree::ptree& config) : SimData42SocketProvider(config)
    {
        sim_logger->trace("Sample42DataProvider::Sample42DataProvider:  Constructor executed");

        connect_reader_thread_as_42_socket_client(
            config.get("simulator.hardware-model.data-provider.hostname", "localhost"),
            config.get("simulator.hardware-model.data-provider.port", 4242) );

        _sc = config.get("simulator.hardware-model.data-provider.spacecraft", 0);
    }

    boost::shared_ptr<SimIDataPoint> Sample42DataProvider::get_data_point(void) const
    {
        sim_logger->trace("Sample42DataProvider::get_data_point:  Executed");

        // Get the 42 data
        const boost::shared_ptr<Sim42DataPoint> dp42 =
            boost::dynamic_pointer_cast<Sim42DataPoint>(SimData42SocketProvider::get_data_point());

        // vvv Prepare the specific data... this may need changed in your use case
        SimIDataPoint *dp = new SampleDataPoint(_sc, dp42);

        return boost::shared_ptr<SimIDataPoint>(dp);
    }
}
