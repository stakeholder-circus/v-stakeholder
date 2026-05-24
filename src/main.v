module main

import os

struct Family {
	id            string
	renderer      string
	tranche       string
	context_key   string
	context_value string
}

const families = [
	Family{'code_analyzer', 'classic-six.code_analyzer', 'classic-six', 'analysisFocus', 'module-ast-audit'},
	Family{'data_processing', 'classic-six.data_processing', 'classic-six', 'dataWindow', 'array-stream-reconciliation'},
	Family{'jargon', 'classic-six.jargon', 'classic-six', 'languagePolicy', 'v-glossary'},
	Family{'metrics', 'classic-six.metrics', 'classic-six', 'signalBlend', 'compile-time-runtime-latency'},
	Family{'network_activity', 'classic-six.network_activity', 'classic-six', 'transportMix', 'socket-http-sse'},
	Family{'system_monitoring', 'classic-six.system_monitoring', 'classic-six', 'telemetryScope', 'v-native-runtime-host'},
	Family{'agent_workflows', 'modern-core.agent_workflows', 'modern-core', 'coordinationMode', 'struct-dispatch-handshake'},
	Family{'platform_engineering', 'modern-core.platform_engineering', 'modern-core', 'platformSurface', 'v-native-validation-lane'},
	Family{'observability_ai_runtime', 'modern-core.observability_ai_runtime', 'modern-core', 'runtimeSignals', 'logs-metrics-provider-boundary'},
	Family{'delivery_preview_ops', 'modern-core.delivery_preview_ops', 'modern-core', 'deliveryGuardrail', 'binary-preview-checkpoints'},
	Family{'supply_chain_security', 'modern-core.supply_chain_security', 'modern-core', 'supplyChainPosture', 'source-binary-attestation'},
	Family{'ai_inference_ops', 'fallback.ai_governance', 'fallback-ai_governance', 'fallbackFamily', 'ai_governance'},
	Family{'evaluation_and_guardrails', 'fallback.ai_governance', 'fallback-ai_governance', 'fallbackFamily', 'ai_governance'},
	Family{'knowledge_retrieval', 'fallback.ai_governance', 'fallback-ai_governance', 'fallbackFamily', 'ai_governance'},
	Family{'edge_client_runtime', 'fallback.ai_governance', 'fallback-ai_governance', 'fallbackFamily', 'ai_governance'},
	Family{'identity_and_trust', 'fallback.ai_governance', 'fallback-ai_governance', 'fallbackFamily', 'ai_governance'},
	Family{'aibom_provenance', 'fallback.ai_governance', 'fallback-ai_governance', 'fallbackFamily', 'ai_governance'},
	Family{'agent_boundary_security', 'fallback.ai_governance', 'fallback-ai_governance', 'fallbackFamily', 'ai_governance'},
	Family{'embedded_agentic_pipeline', 'fallback.ai_governance', 'fallback-ai_governance', 'fallbackFamily', 'ai_governance'},
	Family{'data_governance_compliance', 'fallback.ai_governance', 'fallback-ai_governance', 'fallbackFamily', 'ai_governance'},
	Family{'finops_capacity', 'fallback.ai_governance', 'fallback-ai_governance', 'fallbackFamily', 'ai_governance'},
	Family{'blockchain_protocol_ops', 'fallback.security_blockchain', 'fallback-security_blockchain', 'fallbackFamily', 'security_blockchain'},
	Family{'cross_chain_interop', 'fallback.security_blockchain', 'fallback-security_blockchain', 'fallbackFamily', 'security_blockchain'},
	Family{'proof_and_sequencer_ops', 'fallback.security_blockchain', 'fallback-security_blockchain', 'fallbackFamily', 'security_blockchain'},
	Family{'hybrid_runtime_ops', 'fallback.overlay_quantum', 'fallback-overlay_quantum', 'fallbackFamily', 'overlay_quantum'},
	Family{'capacity_cost_controller', 'fallback.overlay_quantum', 'fallback-overlay_quantum', 'fallbackFamily', 'overlay_quantum'},
	Family{'batch_execution_tuner', 'fallback.overlay_quantum', 'fallback-overlay_quantum', 'fallbackFamily', 'overlay_quantum'},
	Family{'compiler_maintainer', 'fallback.overlay_quantum', 'fallback-overlay_quantum', 'fallbackFamily', 'overlay_quantum'},
	Family{'interop_adapter_engineer', 'fallback.overlay_quantum', 'fallback-overlay_quantum', 'fallbackFamily', 'overlay_quantum'},
	Family{'preflight_capacity_planner', 'fallback.overlay_quantum', 'fallback-overlay_quantum', 'fallbackFamily', 'overlay_quantum'},
	Family{'simulator_performance_engineer', 'fallback.overlay_quantum', 'fallback-overlay_quantum', 'fallbackFamily', 'overlay_quantum'},
	Family{'fhir_profile_generator', 'fallback.health_protocol', 'fallback-health_protocol', 'fallbackFamily', 'health_protocol'},
	Family{'smart_launch_oauth', 'fallback.health_protocol', 'fallback-health_protocol', 'fallbackFamily', 'health_protocol'},
	Family{'bulk_fhir_population_ops', 'fallback.health_protocol', 'fallback-health_protocol', 'fallbackFamily', 'health_protocol'},
	Family{'hl7v2_feed_ops', 'fallback.health_protocol', 'fallback-health_protocol', 'fallbackFamily', 'health_protocol'},
	Family{'clinical_workflow_events', 'fallback.health_protocol', 'fallback-health_protocol', 'fallbackFamily', 'health_protocol'},
	Family{'dicomweb_imaging_ops', 'fallback.health_protocol', 'fallback-health_protocol', 'fallbackFamily', 'health_protocol'},
	Family{'openehr_semantic_record_ops', 'fallback.health_protocol', 'fallback-health_protocol', 'fallbackFamily', 'health_protocol'},
	Family{'device_telemetry_clinical', 'fallback.health_protocol', 'fallback-health_protocol', 'fallbackFamily', 'health_protocol'},
	Family{'emr_vendor_adapter', 'fallback.health_protocol', 'fallback-health_protocol', 'fallbackFamily', 'health_protocol'},
	Family{'ocpp_chargepoint_ops', 'fallback.health_protocol', 'fallback-health_protocol', 'fallbackFamily', 'health_protocol'},
	Family{'ocpi_roaming_ops', 'fallback.health_protocol', 'fallback-health_protocol', 'fallbackFamily', 'health_protocol'},
	Family{'mcp_a2a_ops', 'fallback.health_protocol', 'fallback-health_protocol', 'fallbackFamily', 'health_protocol'},
	Family{'streaming_bus_ops', 'fallback.health_protocol', 'fallback-health_protocol', 'fallbackFamily', 'health_protocol'},
	Family{'service_mesh_rpc_ops', 'fallback.health_protocol', 'fallback-health_protocol', 'fallbackFamily', 'health_protocol'},
]

fn registry_id(value string) string {
	return value.replace('_', '-')
}

fn normalize_family(value string) string {
	return value.to_lower().replace('-', '_')
}

fn find_family(value string) ?Family {
	normalized := normalize_family(value)
	for family in families {
		if family.id == normalized {
			return family
		}
	}
	return none
}

fn deterministic_hash(value string) u32 {
	mut hash := u32(2166136261)
	for ch in value.bytes() {
		hash = hash * 16777619 + u32(ch)
	}
	return hash
}

fn pad2(value u32) string {
	if value < 10 {
		return '0${value}'
	}
	return '${value}'
}

fn quoted_ids(items []Family) string {
	mut ids := []string{}
	for family in items {
		ids << '"${registry_id(family.id)}"'
	}
	return ids.join(',')
}

fn print_registry() {
	mut rows := []string{}
	mut classic := []Family{}
	mut modern := []Family{}
	mut fallback := []Family{}
	for family in families {
		rows << '{"id":"${family.id}","registryId":"${registry_id(family.id)}","rendererKey":"${family.renderer}","tranche":"${family.tranche}"}'
		if family.tranche == 'classic-six' {
			classic << family
		} else if family.tranche == 'modern-core' {
			modern << family
		} else {
			fallback << family
		}
	}
	println('{"outputFormats":["text","json"],"flags":["list-values","focus-family","output-format","seed","experimental-provider"],"generatorFamilies":[${rows.join(',')}],"classicSix":[${quoted_ids(classic)}],"modernCore":[${quoted_ids(modern)}],"fallbackFamilies":[${quoted_ids(fallback)}],"implementationMode":"family-focus-deterministic"}')
}

fn print_payload(family Family, seed string, output_format string) {
	hash := deterministic_hash('${seed}::${family.id}')
	seconds := hash % 86400
	hour := seconds / 3600
	minute := (seconds % 3600) / 60
	second := seconds % 60
	sequence := 1000 + (hash % 9000)
	timestamp := '2026-01-01T${pad2(hour)}:${pad2(minute)}:${pad2(second)}Z'
	fingerprint := '${registry_id(family.id)}-${hash.hex()}'
	if output_format == 'json' {
		println('{"eventType":"stakeholder.generator.output","sequence":${sequence},"family":"${family.id}","message":"Deterministic v tranche for ${family.id}","timestamp":"${timestamp}","context":{"rendererKey":"${family.renderer}","${family.context_key}":"${family.context_value}","seedFingerprint":"${fingerprint}","tranche":"${family.tranche}","vProfile":"vlang-compiled-struct-catalog"},"generationProvenance":{"sourceRepo":"v-stakeholder","baseline":"local-small-tranche-family-focus","experimental":false,"adapterType":"static-struct-catalog","promptVersion":null},"outputFormat":"json"}')
	} else {
		println('family: ${family.id}')
		println('renderer: ${family.renderer}')
		println('tranche: ${family.tranche}')
		println('sequence: ${sequence}')
		println('timestamp: ${timestamp}')
		println('message: Deterministic v tranche for ${family.id}')
	}
}

fn fail(message string) {
	eprintln(message)
	exit(2)
}

fn fail_with(message string, value string) {
	eprintln('${message}: ${value}')
	exit(2)
}

fn main() {
	mut focus_family := ''
	mut seed := 'default-seed'
	mut output_format := 'text'
	mut list_values := false
	mut i := 1
	for i < os.args.len {
		arg := os.args[i]
		match arg {
			'--list-values' {
				list_values = true
				i++
			}
			'--focus-family' {
				if i + 1 >= os.args.len {
					fail('missing value for --focus-family')
				}
				focus_family = os.args[i + 1]
				i += 2
			}
			'--seed' {
				if i + 1 >= os.args.len {
					fail('missing value for --seed')
				}
				seed = os.args[i + 1]
				i += 2
			}
			'--output-format' {
				if i + 1 >= os.args.len {
					fail('missing value for --output-format')
				}
				candidate := os.args[i + 1]
				if candidate != 'text' && candidate != 'json' {
					fail_with('invalid --output-format', candidate)
				}
				output_format = candidate
				i += 2
			}
			'--experimental-provider' {
				if i + 1 >= os.args.len {
					fail('missing value for --experimental-provider')
				}
				fail_with('experimental provider is not enabled in the deterministic first tranche',
					os.args[i + 1])
			}
			else {
				if arg.starts_with('--experimental-') {
					fail('experimental flags require --experimental-provider')
				}
				fail_with('unknown argument', arg)
			}
		}
	}
	if list_values {
		print_registry()
		return
	}
	if focus_family == '' {
		fail('focus-family is required and must be a known generator family')
	}
	family := find_family(focus_family) or {
		fail_with('invalid --focus-family', focus_family)
		return
	}
	print_payload(family, seed, output_format)
}
