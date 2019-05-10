package com.microsoft.cse.kafkaopenhack.javaexamples;

import io.confluent.kafka.serializers.AbstractKafkaAvroSerDeConfig;
import io.confluent.kafka.serializers.KafkaAvroSerializer;
import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerConfig;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.apache.kafka.common.serialization.StringSerializer;
import org.apache.kafka.common.errors.SerializationException;
import java.util.ArrayList;
import java.util.Properties;
import com.google.gson.Gson;

public class SimpleProducer {

    private static final String TOPIC = "schematest-avro";
    private static final String SCHEMA_REGISTRY_URL = "http://40.65.121.104:8081";
    private static final String KAFKA_URL = "52.175.200.191:31090";
    private static final Integer RETRIES = 0;
    private static final String ACKS = "all";

    @SuppressWarnings("InfiniteLoopStatement")
    public static void main(final String[] args) {

        final Properties props = new Properties();
        props.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, KAFKA_URL);
        props.put(ProducerConfig.ACKS_CONFIG, ACKS);
        props.put(ProducerConfig.RETRIES_CONFIG, RETRIES);
        props.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, StringSerializer.class);
        props.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, KafkaAvroSerializer.class);
        props.put(AbstractKafkaAvroSerDeConfig.SCHEMA_REGISTRY_URL_CONFIG, SCHEMA_REGISTRY_URL);

        // auto register schema with registry
        props.put("auto.register.schemas", true);

        try (KafkaProducer<String, String> producer = new KafkaProducer<>(props)) {
            BadgeService.OpenConnection();
            for (long i = 0; i < 10; i++) {
                ArrayList<EventBadge> badgeEvents = BadgeService.GetBadges();
                Gson gson = new Gson();
                badgeEvents.forEach(b -> {
                    String json = gson.toJson(b);
                    final ProducerRecord<String, String> record = new ProducerRecord<>(TOPIC, b.getId(), json);
                    producer.send(record);
                });
            }
            producer.flush();
            BadgeService.CloseConnection();
            System.out.printf("Successfully produced 10 messages to a topic called %s%n", TOPIC);
        } catch (final SerializationException e) {
            e.printStackTrace();
        }
    }
}