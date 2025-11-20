<!--
Sync Impact Report:
Version: 1.1.0 (MINOR bump - added Documentation Language Policy principle)
Ratification: 2025-11-20
Last Amendment: 2025-11-20

Modified Sections:
- Converted entire constitution to English (governance document language)
- Added Principle V: Documentation Language Policy

Added Sections:
- Core Principles: Code Quality, Testing Standards, User Experience Consistency, Performance Requirements, Documentation Language Policy
- Performance Standards: Quantifiable performance benchmarks
- Development Workflow: Quality gates and review process

Templates Status:
✅ plan-template.md - Constitution Check section aligns with new principles
✅ spec-template.md - Requirements and success criteria align with UX/quality principles, MUST output in zh-TW
✅ tasks-template.md - Task categorization supports quality gates and testing discipline, MUST output in zh-TW
✅ checklist-template.md - Compatible with quality verification workflows, MUST output in zh-TW
✅ agent-file-template.md - No constitution-specific references to update, MUST output in zh-TW

Follow-up TODOs: None - all placeholders filled
-->

# Counter Flutter Project Constitution

## Core Principles

### I. Code Quality (NON-NEGOTIABLE)

All code MUST meet the following quality standards:

- **Readability First**: Code MUST clearly express intent; prefer explicit naming over concise but ambiguous naming
- **Single Responsibility**: Each class and function MUST have exactly one clear responsibility; functionality MUST be cohesive
- **DRY Principle**: Logic repeated more than twice MUST be refactored into reusable components
- **Static Analysis Zero Tolerance**: All code MUST pass `flutter analyze` with no warnings; use of `// ignore` is prohibited unless justified in writing during code review
- **Documentation Requirements**: All public APIs and complex logic MUST include Dart doc comments explaining purpose, parameters, and return values

**Rationale**: High-quality code reduces maintenance costs, minimizes bugs, and improves team collaboration efficiency. Quality debt compounds over time; prevention is superior to remediation.

### II. Testing Standards (NON-NEGOTIABLE)

Testing is the cornerstone of quality assurance and MUST be rigorously enforced:

- **Test-First**: New feature development follows the Red-Green-Refactor cycle
  1. Write failing tests
  2. Implement minimum code to pass tests
  3. Refactor while keeping tests passing
- **Coverage Requirements**:
  - Business Logic (BLoC/Provider/Service): **minimum 80% coverage**
  - UI Widgets: **minimum 60% coverage**
  - Utility functions/helper classes: **100% coverage**
- **Test Layering**:
  - **Unit Tests**: Test isolated logic units (functions, class methods)
  - **Widget Tests**: Test UI component behavior and interactions
  - **Integration Tests**: Test end-to-end user flows (critical paths MUST be included)
- **Test Naming**: Use `test('should [expected behavior] when [condition]')` format to clearly describe test intent
- **Test Isolation**: Each test MUST execute independently, without dependency on execution order or shared state

**Rationale**: Tests provide a regression safety net, ensuring changes don't break existing functionality. Test-first forces developers to think about API design and edge cases.

### III. User Experience Consistency

User interfaces MUST provide smooth, consistent, and platform-compliant experiences:

- **Design System Adherence**:
  - Use unified design tokens (colors, fonts, spacing)
  - Build reusable UI component library (buttons, input fields, cards, etc.)
  - Hardcoding style values in business logic layer is prohibited
- **Platform Consistency**:
  - Follow Material Design 3 guidelines
  - Support system themes (light/dark mode)
  - Respect system accessibility settings (font size, screen readers)
- **Interaction Feedback**:
  - All user actions MUST provide immediate visual feedback (loading states, button press effects)
  - Error messages MUST clearly guide users on how to correct issues
  - Long-running operations (>500ms) MUST display progress indicators
- **Accessibility**:
  - All interactive components MUST support keyboard/voice navigation
  - Use `Semantics` widgets to provide descriptions for screen readers
  - Color contrast ratios MUST meet WCAG AA standards (minimum 4.5:1)

**Rationale**: Consistent experiences build user trust and reduce learning curves. Accessible design expands user reach and meets regulatory requirements.

### IV. Performance Requirements

Applications MUST execute smoothly on target devices, meeting the following performance benchmarks:

- **Frame Rate Performance**:
  - Maintain **60 FPS** (16ms/frame); complex animation scenes may drop to 55 FPS
  - Expensive computations or I/O operations are prohibited in `build()` methods
  - Use `const` constructors to reduce unnecessary widget rebuilds
- **Startup Time**:
  - Cold start to first interactive screen: **< 3 seconds** (mid-range devices)
  - Hot reload response time: **< 500ms**
- **Memory Usage**:
  - Application peak memory: **< 150MB** (excluding cached data)
  - Images MUST use appropriate sizes and formats; avoid loading original high-resolution images
  - Lists MUST use `ListView.builder` or `GridView.builder` for virtual scrolling
- **Network Requests**:
  - API requests MUST set timeout limits (default 30 seconds)
  - Implement request caching strategies to avoid redundant requests for identical data
  - Large data MUST use pagination
- **Performance Monitoring**:
  - Use Flutter DevTools to regularly check for performance bottlenecks
  - Critical paths MUST pass performance tests (`integration_test` + performance profiling)
  - Pre-release MUST validate performance on low-end devices (memory < 2GB)

**Rationale**: Performance directly impacts user satisfaction and retention. Smooth experiences are fundamental requirements for high-quality applications.

### V. Documentation Language Policy (NON-NEGOTIABLE)

Language usage MUST follow strict separation to maintain consistency and clarity:

- **Constitution & Governance** (English):
  - This constitution document MUST be written in English
  - Governance documents, amendment proposals, and compliance reports MUST be in English
  - Rationale: Universal accessibility for technical stakeholders and future team expansion
- **User-Facing Documentation** (Traditional Chinese - zh-TW):
  - ALL specifications (`spec.md`) MUST be written in Traditional Chinese
  - ALL implementation plans (`plan.md`) MUST be written in Traditional Chinese
  - ALL task lists (`tasks.md`) MUST be written in Traditional Chinese
  - ALL checklists MUST be written in Traditional Chinese
  - ALL quickstart guides and end-user documentation MUST be written in Traditional Chinese
  - ALL generated files from `/speckit.*` commands MUST output in Traditional Chinese
  - Rationale: Ensures clarity for local users, stakeholders, and team members
- **Code & Technical Artifacts** (English):
  - Code comments, variable names, function names MUST be in English
  - Commit messages MUST be in English (Conventional Commits format)
  - Technical logs and error messages MUST be in English
  - Rationale: Industry standard practice for international collaboration and tooling compatibility
- **Exceptions**:
  - User-visible UI strings MAY be in Traditional Chinese (use i18n for localization)
  - Technical discussions in code reviews MAY use either language based on team preference

**Rationale**: Clear language policy eliminates ambiguity, ensures consistency across artifacts, and facilitates proper audience targeting (technical governance vs. user-facing specifications).

## Development Workflow

### Code Review

All code changes MUST undergo review before merging:

- **Review Checklist**:
  - ✅ Complies with all core constitutional principles
  - ✅ Test coverage meets targets and all tests pass
  - ✅ Static analysis shows no warnings
  - ✅ No code smells (overly long functions, deep nesting, magic numbers)
  - ✅ Changes include necessary documentation updates
  - ✅ Documentation language policy is followed (specs/plans in zh-TW, code/commits in English)
- **Review Timeliness**: Code reviews MUST receive initial feedback within 24 hours
- **Constructive Feedback**: Review comments MUST be specific and provide improvement suggestions; avoid vague or subjective criticism

### Quality Gates

Code MUST pass the following automated checks before merging:

1. **Static Analysis**: `flutter analyze` with zero errors/warnings
2. **Formatting**: `dart format --set-exit-if-changed .` passes
3. **Test Suite**: All tests pass and coverage meets targets
4. **Build Verification**: `flutter build apk/ios` completes successfully

### Version Control

- **Branching Strategy**: Use feature branches (`###-feature-name`) for development, merge to `main` upon completion
- **Commit Messages**: Follow Conventional Commits format in English (`feat:`, `fix:`, `docs:`, `test:`, `refactor:`)
- **Change Tracking**: Use `/speckit.*` commands to create specification documents and task tracking (outputs in zh-TW)

## Technical Constraints

### Technology Stack

- **Flutter SDK**: Minimum version 3.10 (stable)
- **Dart Version**: Minimum 3.0
- **State Management**: Prefer `flutter_bloc` or `provider` for consistency
- **Network Requests**: Use `dio` or `http` package
- **Local Storage**: `shared_preferences` (settings), `sqflite` (structured data), `hive` (high-performance NoSQL)

### Dependency Management

- Adding third-party packages MUST evaluate:
  - Package maintenance status (updated within last 6 months)
  - Community support (pub.dev score > 130)
  - License compatibility
- Regular dependency updates (monthly checks) to fix known vulnerabilities

## Governance

### Constitutional Priority

This constitution supersedes all other development practices and personal preferences. Any conflicts defer to the constitution.

### Amendment Process

Constitutional amendments MUST follow this process:

1. **Proposal**: Write amendment proposal explaining rationale, impact scope, and migration plan
2. **Review**: Team reviews and discusses proposal
3. **Approval**: Update constitution after consensus
4. **Versioning**: Update version number and amendment date
5. **Synchronization**: Update all related templates and documentation

### Versioning Rules

- **MAJOR**: Remove or redefine core principles (breaking changes)
- **MINOR**: Add new principles or sections
- **PATCH**: Clarifications, typo fixes, non-semantic modifications

### Compliance Review

- All Pull Requests MUST verify constitutional compliance
- Monthly codebase health audits checking test coverage, static analysis results, and performance metrics
- Complexity increases (e.g., adding third-party services, architectural changes) MUST be explicitly justified in code reviews

### Runtime Development Guidance

- Use development guidance files generated from `.specify/templates/agent-file-template.md` as daily development reference (outputs in zh-TW)
- Use `.github/prompts/speckit.*.prompt.md` commands for specification-driven development workflows (outputs in zh-TW)

**Version**: 1.1.0 | **Ratified**: 2025-11-20 | **Last Amended**: 2025-11-20
