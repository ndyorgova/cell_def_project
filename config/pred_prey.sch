<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <title>PhysiCell Settings Validation</title>
    <ns prefix="pc" uri="http://physicell.org"/>
    
    <!-- Domain Validation -->
    <pattern>
        <title>Domain Configuration Rules</title>
        <rule context="domain">
            <assert test="number(x_max) > number(x_min)">
                x_max must be greater than x_min
            </assert>
            <assert test="number(y_max) > number(y_min)">
                y_max must be greater than y_min
            </assert>
            <assert test="number(z_max) > number(z_min)">
                z_max must be greater than z_min
            </assert>
            <assert test="number(dx) > 0">
                dx must be positive
            </assert>
            <assert test="number(dy) > 0">
                dy must be positive
            </assert>
            <assert test="number(dz) > 0">
                dz must be positive
            </assert>
            <assert test="use_2D = 'true' or use_2D = 'false'">
                use_2D must be either 'true' or 'false'
            </assert>
        </rule>
    </pattern>
    
    <!-- Overall Timing Validation -->
    <pattern>
        <title>Overall Timing Configuration Rules</title>
        <rule context="overall">
            <assert test="number(max_time) > 0">
                max_time must be positive
            </assert>
            <assert test="number(dt_diffusion) > 0">
                dt_diffusion must be positive
            </assert>
            <assert test="number(dt_mechanics) > 0">
                dt_mechanics must be positive
            </assert>
            <assert test="number(dt_phenotype) > 0">
                dt_phenotype must be positive
            </assert>
            <assert test="number(dt_mechanics) >= number(dt_diffusion)">
                dt_mechanics should be greater than or equal to dt_diffusion
            </assert>
        </rule>
    </pattern>
    
    <!-- Parallel Configuration -->
    <pattern>
        <title>Parallel Configuration Rules</title>
        <rule context="parallel">
            <assert test="number(omp_num_threads) >= 1">
                omp_num_threads must be at least 1
            </assert>
        </rule>
    </pattern>
    
    <!-- Save Configuration -->
    <pattern>
        <title>Save Configuration Rules</title>
        <rule context="save/full_data">
            <assert test="number(interval) > 0">
                full_data interval must be positive
            </assert>
            <assert test="enable = 'true' or enable = 'false'">
                enable must be either 'true' or 'false'
            </assert>
        </rule>
        <rule context="save/SVG">
            <assert test="number(interval) > 0">
                SVG interval must be positive
            </assert>
            <assert test="enable = 'true' or enable = 'false'">
                enable must be either 'true' or 'false'
            </assert>
        </rule>
    </pattern>
    
    <!-- Microenvironment Validation -->
    <pattern>
        <title>Microenvironment Variable Rules</title>
        <rule context="microenvironment_setup/variable">
            <assert test="@name and string-length(@name) > 0">
                Variable must have a non-empty name attribute
            </assert>
            <assert test="@ID and number(@ID) >= 0">
                Variable must have a non-negative ID attribute
            </assert>
            <assert test="number(physical_parameter_set/diffusion_coefficient) >= 0">
                diffusion_coefficient must be non-negative
            </assert>
            <assert test="number(physical_parameter_set/decay_rate) >= 0">
                decay_rate must be non-negative
            </assert>
        </rule>
    </pattern>
    
    <!-- Cell Definition Validation -->
    <pattern>
        <title>Cell Definition Rules</title>
        <rule context="cell_definitions/cell_definition">
            <assert test="@name and string-length(@name) > 0">
                Cell definition must have a non-empty name attribute
            </assert>
            <assert test="@ID and number(@ID) >= 0">
                Cell definition must have a non-negative ID attribute
            </assert>
        </rule>
    </pattern>
    
    <!-- Cycle Validation -->
    <pattern>
        <title>Cell Cycle Rules</title>
        <rule context="cell_definition/phenotype/cycle">
            <assert test="@code and number(@code) >= 0">
                Cycle must have a non-negative code attribute
            </assert>
            <assert test="phase_transition_rates/rate/@start_index and number(phase_transition_rates/rate/@start_index) >= 0">
                Phase transition rate start_index must be non-negative
            </assert>
            <assert test="phase_transition_rates/rate/@end_index and number(phase_transition_rates/rate/@end_index) >= 0">
                Phase transition rate end_index must be non-negative
            </assert>
        </rule>
    </pattern>
    
    <!-- Death Model Validation -->
    <pattern>
        <title>Death Model Rules</title>
        <rule context="death/model">
            <assert test="@code and number(@code) >= 0">
                Death model must have a non-negative code attribute
            </assert>
            <assert test="number(death_rate) >= 0">
                death_rate must be non-negative
            </assert>
            <assert test="every $duration in phase_durations/duration satisfies number($duration) >= 0">
                All phase durations must be non-negative
            </assert>
        </rule>
    </pattern>
    
    <!-- Volume Validation -->
    <pattern>
        <title>Volume Rules</title>
        <rule context="phenotype/volume">
            <assert test="number(total) > 0">
                Total volume must be positive
            </assert>
            <assert test="number(fluid_fraction) >= 0 and number(fluid_fraction) <= 1">
                fluid_fraction must be between 0 and 1
            </assert>
            <assert test="number(nuclear) > 0">
                Nuclear volume must be positive
            </assert>
            <assert test="number(nuclear) &lt; number(total)">
                Nuclear volume must be less than total volume
            </assert>
            <assert test="number(calcified_fraction) >= 0 and number(calcified_fraction) <= 1">
                calcified_fraction must be between 0 and 1
            </assert>
            <assert test="number(relative_rupture_volume) > 0">
                relative_rupture_volume must be positive
            </assert>
        </rule>
    </pattern>
    
    <!-- Mechanics Validation -->
    <pattern>
        <title>Mechanics Rules</title>
        <rule context="phenotype/mechanics">
            <assert test="number(cell_cell_adhesion_strength) >= 0">
                cell_cell_adhesion_strength must be non-negative
            </assert>
            <assert test="number(cell_cell_repulsion_strength) >= 0">
                cell_cell_repulsion_strength must be non-negative
            </assert>
            <assert test="number(relative_maximum_adhesion_distance) > 0">
                relative_maximum_adhesion_distance must be positive
            </assert>
            <assert test="number(maximum_number_of_attachments) >= 0">
                maximum_number_of_attachments must be non-negative
            </assert>
        </rule>
    </pattern>
    
    <!-- Motility Validation -->
    <pattern>
        <title>Motility Rules</title>
        <rule context="phenotype/motility">
            <assert test="number(speed) >= 0">
                Motility speed must be non-negative
            </assert>
            <assert test="number(persistence_time) > 0">
                persistence_time must be positive
            </assert>
            <assert test="number(migration_bias) >= 0 and number(migration_bias) <= 1">
                migration_bias must be between 0 and 1
            </assert>
        </rule>
        <rule context="motility/options/chemotaxis[enabled='true']">
            <assert test="substrate and string-length(substrate) > 0">
                Enabled chemotaxis must specify a substrate
            </assert>
            <assert test="direction = '1' or direction = '-1'">
                Chemotaxis direction must be 1 (towards) or -1 (away)
            </assert>
        </rule>
    </pattern>
    
    <!-- Secretion Validation -->
    <pattern>
        <title>Secretion Rules</title>
        <rule context="secretion/substrate">
            <assert test="@name and string-length(@name) > 0">
                Substrate must have a non-empty name attribute
            </assert>
            <assert test="number(secretion_rate) >= 0">
                secretion_rate must be non-negative
            </assert>
            <assert test="number(uptake_rate) >= 0">
                uptake_rate must be non-negative
            </assert>
        </rule>
    </pattern>
    
    <!-- Cell Interactions Validation -->
    <pattern>
        <title>Cell Interactions Rules</title>
        <rule context="cell_interactions">
            <assert test="number(apoptotic_phagocytosis_rate) >= 0">
                apoptotic_phagocytosis_rate must be non-negative
            </assert>
            <assert test="number(necrotic_phagocytosis_rate) >= 0">
                necrotic_phagocytosis_rate must be non-negative
            </assert>
            <assert test="number(other_dead_phagocytosis_rate) >= 0">
                other_dead_phagocytosis_rate must be non-negative
            </assert>
            <assert test="number(attack_damage_rate) >= 0">
                attack_damage_rate must be non-negative
            </assert>
            <assert test="number(attack_duration) >= 0">
                attack_duration must be non-negative
            </assert>
        </rule>
        <rule context="cell_interactions//phagocytosis_rate">
            <assert test="number(.) >= 0">
                All phagocytosis rates must be non-negative
            </assert>
        </rule>
        <rule context="cell_interactions//attack_rate">
            <assert test="number(.) >= 0">
                All attack rates must be non-negative
            </assert>
        </rule>
        <rule context="cell_interactions//fusion_rate">
            <assert test="number(.) >= 0">
                All fusion rates must be non-negative
            </assert>
        </rule>
    </pattern>
    
    <!-- Cell Integrity Validation -->
    <pattern>
        <title>Cell Integrity Rules</title>
        <rule context="cell_integrity">
            <assert test="number(damage_rate) >= 0">
                damage_rate must be non-negative
            </assert>
            <assert test="number(damage_repair_rate) >= 0">
                damage_repair_rate must be non-negative
            </assert>
        </rule>
    </pattern>
    
    <!-- Initial Conditions Validation -->
    <pattern>
        <title>Initial Conditions Rules</title>
        <rule context="initial_conditions/cell_positions[@enabled='true']">
            <assert test="filename and string-length(filename) > 0">
                Enabled cell_positions must specify a filename
            </assert>
        </rule>
    </pattern>
    
    <!-- Cell Rules Validation -->
    <pattern>
        <title>Cell Rules Configuration</title>
        <rule context="cell_rules/rulesets/ruleset[@enabled='true']">
            <assert test="filename and string-length(filename) > 0">
                Enabled ruleset must specify a filename
            </assert>
        </rule>
    </pattern>
    
    <!-- User Parameters Validation -->
    <pattern>
        <title>User Parameters Rules</title>
        <rule context="user_parameters/*[@type='int']">
            <assert test="string(number(.)) != 'NaN'">
                Integer parameter must contain a valid number
            </assert>
        </rule>
    </pattern>
    
    <!-- Cross-reference Validation -->
    <pattern>
        <title>Cross-reference Rules</title>
        <rule context="motility/options/chemotaxis[enabled='true']/substrate">
            <let name="substrate_name" value="."/>
            <assert test="//microenvironment_setup/variable[@name=$substrate_name]">
                Chemotaxis substrate '<value-of select="$substrate_name"/>' must be defined in microenvironment_setup
            </assert>
        </rule>
        <rule context="secretion/substrate">
            <let name="substrate_name" value="@name"/>
            <assert test="//microenvironment_setup/variable[@name=$substrate_name]">
                Secretion substrate '<value-of select="$substrate_name"/>' must be defined in microenvironment_setup
            </assert>
        </rule>
    </pattern>
    
</schema>
